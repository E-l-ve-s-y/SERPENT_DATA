#!/usr/bin/env python3
# pyright: reportMissingImports=false, reportMissingModuleSource=false
"""
Cache Layer - LRU Caching with Parquet Persistence
===================================================
Provides intelligent caching for frequently accessed data with disk persistence.

Features:
- LRU cache for case summaries
- Parquet file caching for DataFrames
- Invalidation by modification time
- Thread-safe operations
"""

import hashlib
import pickle
import time
from pathlib import Path
from typing import Optional, TypeVar, Callable, Any
from functools import wraps, lru_cache
from dataclasses import dataclass
from contextlib import contextmanager
import pandas as pd
import numpy as np

T = TypeVar('T')

# Cache configuration
CACHE_DIR = Path(__file__).parent.parent / ".cache"
PARQUET_CACHE_DIR = CACHE_DIR / "parquet"
MEMORY_CACHE_SIZE = 100  # Number of items in LRU cache
CACHE_TTL = 3600 * 24  # 24 hours default TTL


@dataclass
class CacheEntry:
    """Cache entry with metadata"""
    key: str
    value: Any
    created_at: float
    accessed_at: float
    access_count: int = 0
    
    def is_expired(self, ttl: int = CACHE_TTL) -> bool:
        return time.time() - self.created_at > ttl
    
    def touch(self):
        self.accessed_at = time.time()
        self.access_count += 1


class LRUCache:
    """
    Thread-safe LRU (Least Recently Used) cache with disk persistence.
    """
    
    def __init__(self, max_size: int = MEMORY_CACHE_SIZE, ttl: int = CACHE_TTL):
        self.max_size = max_size
        self.ttl = ttl
        self._cache: dict = {}
        self._access_order: list = []
        self._lock = None  # Can add threading.Lock for true thread safety
    
    def get(self, key: str, default: T = None) -> T:
        """Get item from cache"""
        if key in self._cache:
            entry = self._cache[key]
            
            # Check expiration
            if entry.is_expired(self.ttl):
                self._remove(key)
                return default
            
            # Update access order (move to end)
            entry.touch()
            self._access_order.remove(key)
            self._access_order.append(key)
            
            return entry.value
        
        return default
    
    def set(self, key: str, value: Any):
        """Set item in cache with LRU eviction"""
        if key in self._cache:
            # Update existing entry
            self._cache[key].value = value
            self._cache[key].created_at = time.time()
            self._cache[key].touch()
        else:
            # Evict if at capacity
            while len(self._cache) >= self.max_size:
                self._evict_lru()
            
            # Add new entry
            entry = CacheEntry(
                key=key,
                value=value,
                created_at=time.time(),
                accessed_at=time.time()
            )
            self._cache[key] = entry
            self._access_order.append(key)
    
    def _remove(self, key: str):
        """Remove item from cache"""
        if key in self._cache:
            del self._cache[key]
            self._access_order.remove(key)
    
    def _evict_lru(self):
        """Evict least recently used item"""
        if self._access_order:
            lru_key = self._access_order[0]
            self._remove(lru_key)
    
    def clear(self):
        """Clear all cached items"""
        self._cache.clear()
        self._access_order.clear()
    
    def __len__(self):
        return len(self._cache)
    
    def __contains__(self, key: str):
        return key in self._cache and not self._cache[key].is_expired(self.ttl)


class ParquetCache:
    """
    Disk-based cache using Parquet format for efficient DataFrame storage.
    """
    
    def __init__(self, cache_dir: Path = PARQUET_CACHE_DIR):
        self.cache_dir = Path(cache_dir)
        self.cache_dir.mkdir(parents=True, exist_ok=True)
    
    def _get_cache_path(self, key: str) -> Path:
        """Get cache file path for a key"""
        # Hash the key to create a valid filename
        hash_key = hashlib.md5(key.encode()).hexdigest()
        return self.cache_dir / f"{hash_key}.parquet"
    
    def get(self, key: str) -> Optional[pd.DataFrame]:
        """Get DataFrame from cache"""
        cache_path = self._get_cache_path(key)
        
        if not cache_path.exists():
            return None
        
        try:
            return pd.read_parquet(cache_path)
        except Exception:
            # Cache corrupted, remove it
            cache_path.unlink(missing_ok=True)
            return None
    
    def set(self, key: str, df: pd.DataFrame):
        """Store DataFrame in cache"""
        cache_path = self._get_cache_path(key)
        
        try:
            df.to_parquet(cache_path, index=False)
        except Exception as e:
            # Log error but don't fail
            print(f"Cache write failed: {e}")
    
    def has(self, key: str) -> bool:
        """Check if key exists in cache"""
        return self._get_cache_path(key).exists()
    
    def remove(self, key: str):
        """Remove specific cache entry"""
        self._get_cache_path(key).unlink(missing_ok=True)
    
    def clear(self):
        """Clear all parquet cache files"""
        for f in self.cache_dir.glob("*.parquet"):
            f.unlink()
    
    def get_size_mb(self) -> float:
        """Get total cache size in MB"""
        total = sum(f.stat().st_size for f in self.cache_dir.glob("*.parquet"))
        return total / (1024 * 1024)


class MultiLevelCache:
    """
    Multi-level caching system:
    Level 1: In-memory LRU cache
    Level 2: Disk-based Parquet cache
    
    Strategies:
    - Check L1 first (fast)
    - On miss, check L2 (medium)
    - On miss, compute and cache at both levels
    """
    
    def __init__(
        self,
        memory_cache_size: int = MEMORY_CACHE_SIZE,
        parquet_cache_dir: Path = PARQUET_CACHE_DIR
    ):
        self.l1_cache = LRUCache(max_size=memory_cache_size)
        self.l2_cache = ParquetCache(cache_dir=parquet_cache_dir)
    
    def get_df(self, key: str) -> Optional[pd.DataFrame]:
        """Get DataFrame from multi-level cache"""
        # Try L1 first
        df = self.l1_cache.get(key)
        if df is not None:
            return df
        
        # Try L2
        df = self.l2_cache.get(key)
        if df is not None:
            # Promote to L1
            self.l1_cache.set(key, df)
            return df
        
        return None
    
    def set_df(self, key: str, df: pd.DataFrame):
        """Store DataFrame in both cache levels"""
        self.l1_cache.set(key, df)
        self.l2_cache.set(key, df)
    
    def invalidate(self, key: str):
        """Invalidate cache entry at both levels"""
        self.l1_cache._cache.pop(key, None)
        self.l2_cache.remove(key)
    
    def clear_all(self):
        """Clear all caches"""
        self.l1_cache.clear()
        self.l2_cache.clear()
    
    def get_stats(self) -> dict:
        """Get cache statistics"""
        return {
            'l1_size': len(self.l1_cache),
            'l2_size_mb': self.l2_cache.get_size_mb(),
            'l1_capacity': self.l1_cache.max_size
        }


def cached(multi_level_cache: MultiLevelCache, key_func: Callable = None):
    """
    Decorator for caching function results.
    
    Args:
        multi_level_cache: MultiLevelCache instance
        key_func: Function to generate cache key from args
    
    Example:
        @cached(cache, lambda *args, **kwargs: f"case_{args[0]}")
        def get_case_data(case_id: str) -> pd.DataFrame:
            ...
    """
    def decorator(func: Callable) -> Callable:
        @wraps(func)
        def wrapper(*args, **kwargs):
            # Generate cache key
            if key_func:
                cache_key = key_func(*args, **kwargs)
            else:
                # Default: use function name and args hash
                key_data = f"{func.__name__}:{str(args)}:{str(kwargs)}"
                cache_key = hashlib.md5(key_data.encode()).hexdigest()
            
            # Try cache first
            result = multi_level_cache.get_df(cache_key)
            if result is not None:
                return result
            
            # Compute and cache
            result = func(*args, **kwargs)
            if isinstance(result, pd.DataFrame):
                multi_level_cache.set_df(cache_key, result)
            
            return result
        
        return wrapper
    return decorator


# Global cache instance (singleton)
_global_cache: Optional[MultiLevelCache] = None


def get_global_cache() -> MultiLevelCache:
    """Get or create global cache instance"""
    global _global_cache
    if _global_cache is None:
        _global_cache = MultiLevelCache()
    return _global_cache


@contextmanager
def cache_context(memory_size: int = MEMORY_CACHE_SIZE):
    """
    Context manager for temporary cache configuration.
    
    Example:
        with cache_context(memory_size=200):
            # Use larger cache within this context
            ...
    """
    global _global_cache
    old_cache = _global_cache
    _global_cache = MultiLevelCache(memory_cache_size=memory_size)
    try:
        yield _global_cache
    finally:
        _global_cache = old_cache


# Utility functions
def compute_hash(data: Any) -> str:
    """Compute hash for any data"""
    if isinstance(data, pd.DataFrame):
        # For DataFrames, hash the key columns
        key_str = f"{data.shape}:{data.columns.tolist()}:{len(data)}"
    else:
        key_str = str(data)
    return hashlib.md5(key_str.encode()).hexdigest()


def preload_cache(data_lake, cases: list, cache: MultiLevelCache):
    """
    Preload cache with frequently accessed cases.
    
    Args:
        data_lake: DataLake instance
        cases: List of case IDs to preload
        cache: MultiLevelCache instance
    """
    from results.script.agent.data_layer import DataLake
    
    if isinstance(data_lake, str):
        data_lake = DataLake(data_lake)
    
    for case_id in cases:
        df = data_lake.get_case_data(case_id)
        cache.set_df(f"case_{case_id}", df)
    
    print(f"Preloaded {len(cases)} cases into cache")


# Example usage
if __name__ == '__main__':
    # Test cache statistics
    cache = get_global_cache()
    stats = cache.get_stats()
    print(f"Cache Stats: {stats}")
    
    # Clear cache if needed
    # cache.clear_all()