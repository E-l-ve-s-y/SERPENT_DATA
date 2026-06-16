import re
import numpy as np
from pathlib import Path

# ==========================================================
# Serpent变量读取
# ==========================================================

def extract_all_values(text, variable):

    pattern = (
        rf"{variable}"
        r".*?=\s*\[\s*"
        r"([Ee0-9+\-.]+)"
    )

    matches = re.findall(pattern, text, re.S)

    return np.array(
        [float(x) for x in matches]
    )


# ==========================================================
# Case对象
# ==========================================================

class SerpentCase:

    def __init__(self, case_dir):

        self.case_dir = Path(case_dir)

        self.name = self.case_dir.name

        self.res_file = self.find_res_file()

        self.dep_file = self.find_dep_file()

        self.det_files = self.find_detector_files()

        self.res_data = None

    # ------------------------------------------------------

    def find_res_file(self):

        files = list(
            self.case_dir.glob("*_res.m")
        )

        if not files:

            files = list(
                self.case_dir.glob("*.sss_res.m")
            )

        if not files:

            raise FileNotFoundError(
                f"{self.name} 未找到res文件"
            )

        return files[0]

    # ------------------------------------------------------

    def find_dep_file(self):

        files = list(
            self.case_dir.glob("*_dep.m")
        )

        return files[0] if files else None

    # ------------------------------------------------------

    def find_detector_files(self):

        return sorted(
            self.case_dir.glob("*_det*.m")
        )

    # ------------------------------------------------------

    def read_res(self):

        with open(
            self.res_file,
            "r",
            encoding="utf-8",
            errors="ignore"
        ) as f:

            text = f.read()

        self.res_data = {

            "keff":
            extract_all_values(
                text,
                "ANA_KEFF"
            ),

            "cr":
            extract_all_values(
                text,
                "CONVERSION_RATIO"
            ),

            "burnup":
            extract_all_values(
                text,
                "BURNUP"
            ),

            "tot_power":
            extract_all_values(
                text,
                "TOT_POWER"
            )

        }

        return self.res_data


# ==========================================================
# Project对象
# ==========================================================

class SerpentProject:

    def __init__(self, base_dir):

        self.base_dir = Path(base_dir)

        self.cases = {}

    # ------------------------------------------------------

    def scan(self):

        for folder in sorted(
            self.base_dir.iterdir()
        ):

            if not folder.is_dir():
                continue

            try:

                case = SerpentCase(folder)

                self.cases[
                    case.name
                ] = case

            except Exception as e:

                print(
                    f"跳过 {folder.name}"
                )

                print(e)

        print(
            f"\n发现 {len(self.cases)} 个工况"
        )

        return self.cases

    # ------------------------------------------------------

    def load_all(self):

        for case in self.cases.values():

            case.read_res()

        return self.cases


