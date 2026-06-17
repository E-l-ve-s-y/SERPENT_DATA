"""
run_all.py
==========

Run every analysis script in this folder, in order.

All console output is mirrored ("tee'd") to a timestamped log file in
D:\\serpent_data\\results\\analysis\\MOX_Th_kaist\\kaist\\.
"""

import subprocess
import sys
import time
from datetime import datetime
from pathlib import Path

HERE = Path(__file__).resolve().parent
LOG_DIR = Path(r"D:\serpent_data\results\analysis\MOX_Th_kaist\kaist")

SCRIPTS = [
    "plot_reactivity_breeding_tradeoff.py",
    "plot_neutron_spectrum.py",
    "plot_th232_capture_response.py",
    "plot_isotope_evolution.py",
    "plot_isotope_comparison.py",
    "plot_pin_power.py",
]


def main() -> int:
    t0 = time.time()
    failed: list[str] = []

    LOG_DIR.mkdir(parents=True, exist_ok=True)
    log_path = LOG_DIR / f"run_all_{datetime.now():%Y%m%d_%H%M%S}.log"

    with open(log_path, "w", encoding="utf-8") as log_file:
        def emit(msg: str = "") -> None:
            """Print a single line to both the terminal and the log file."""
            print(msg, flush=True)
            log_file.write(msg + "\n")
            log_file.flush()

        def tee(text: str) -> None:
            """Write a chunk of text (newline already included) to both."""
            sys.stdout.write(text)
            sys.stdout.flush()
            log_file.write(text)
            log_file.flush()

        emit(f"=== run_all.py started at {datetime.now():%Y-%m-%d %H:%M:%S} ===")
        emit(f"Log file: {log_path}")
        emit("")

        for script in SCRIPTS:
            path = HERE / script
            if not path.exists():
                emit(f"[missing] {script}")
                failed.append(script)
                continue

            emit(f"\n>>> {script}")
            t = time.time()
            # -u forces unbuffered stdout in the child so output streams live
            # stderr is merged into stdout so the log captures everything
            process = subprocess.Popen(
                [sys.executable, "-u", str(path)],
                cwd=str(HERE),
                stdout=subprocess.PIPE,
                stderr=subprocess.STDOUT,
                text=True,
                encoding="utf-8",
                errors="ignore",
                bufsize=1,
            )
            assert process.stdout is not None
            for line in process.stdout:
                tee(line)
            process.stdout.close()
            returncode = process.wait()
            dt = time.time() - t

            status = "OK" if returncode == 0 else f"FAILED (rc={returncode})"
            emit(f"<<< {status} ({dt:.1f} s)")
            if returncode != 0:
                failed.append(script)

        total = time.time() - t0
        emit("")
        if failed:
            emit(f"{len(failed)} script(s) failed: {failed}")
            emit(
                f"=== run_all.py finished at {datetime.now():%Y-%m-%d %H:%M:%S} "
                f"(FAILED) ==="
            )
            return 1
        emit(f"All {len(SCRIPTS)} scripts completed in {total:.1f} s")
        emit(f"=== run_all.py finished at {datetime.now():%Y-%m-%d %H:%M:%S} ===")
        return 0


if __name__ == "__main__":
    sys.exit(main())
