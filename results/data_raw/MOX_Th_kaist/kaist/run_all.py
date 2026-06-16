"""
run_all.py
==========

Run every analysis script in this folder, in order.
"""

import subprocess
import sys
import time
from pathlib import Path

HERE = Path(__file__).resolve().parent

SCRIPTS = [
    "plot_reactivity_breeding_tradeoff.py",
    "plot_neutron_spectrum.py",
    "plot_th232_capture_response.py",
    "plot_isotope_evolution.py",
    "plot_isotope_comparison.py",
]


def main():
    t0 = time.time()
    failed = []

    for script in SCRIPTS:
        path = HERE / script
        if not path.exists():
            print(f"[missing] {script}")
            failed.append(script)
            continue
        print(f"\n>>> {script}")
        t = time.time()
        result = subprocess.run([sys.executable, str(path)], cwd=str(HERE))
        dt = time.time() - t
        status = "OK" if result.returncode == 0 else f"FAILED (rc={result.returncode})"
        print(f"<<< {status} ({dt:.1f} s)")
        if result.returncode != 0:
            failed.append(script)

    total = time.time() - t0
    print()
    if failed:
        print(f"{len(failed)} script(s) failed: {failed}")
        return 1
    print(f"All {len(SCRIPTS)} scripts completed in {total:.1f} s")
    return 0


if __name__ == "__main__":
    sys.exit(main())
