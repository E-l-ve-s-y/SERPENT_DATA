#!/usr/bin/env python3
"""批量生成钍基压水堆36个Serpent输入卡（A/B/C分组风格）。"""

from __future__ import annotations

import argparse
import csv
import math
from pathlib import Path
from typing import Any

TEMPLATE_HOMO = Path("templates/template_homo.sss")

AVOGADRO = 6.02214076e23
ATOMS_PER_ATOM_B_CM = 1.0e24
OXYGEN_ATOMS_PER_HM_ATOM = 2.0
O16_MOLAR_MASS = 16.0

# 17x17组件，采用与A001一致的导向管位置（25个），燃料棒数量=264。
GUIDE_TUBE_POSITIONS = {
	(2, 5), (2, 8), (2, 11),
	(3, 3), (3, 13),
	(5, 2), (5, 5), (5, 8), (5, 11), (5, 14),
	(8, 2), (8, 5), (8, 8), (8, 11), (8, 14),
	(11, 2), (11, 5), (11, 8), (11, 11), (11, 14),
	(13, 3), (13, 13),
	(14, 5), (14, 8), (14, 11),
}


def parse_args() -> argparse.Namespace:
	parser = argparse.ArgumentParser()
	parser.add_argument("--csv", default="results/data_raw/cases.csv", help="24算例CSV文件")
	parser.add_argument("--template", default=str(TEMPLATE_HOMO), help="模板文件路径")
	parser.add_argument("--output-root", default="cases", help="输出根目录")
	parser.add_argument("--case-prefix", default="A", help="案例编号前缀，如A/B/C")

	parser.add_argument("--temp", type=int, default=900, help="燃料温度(K)")
	parser.add_argument("--acelib", default="/home/sy_lu/data/endfb7/sss_endfb7u.xsdata")
	parser.add_argument("--declib", default="/home/sy_lu/data/endfb7/sss_endfb7.dec")
	parser.add_argument("--nfylib", default="/home/sy_lu/data/endfb7/sss_endfb7.nfy")

	parser.add_argument("--pin-pitch", type=float, default=1.260, help="晶格节距(cm)")
	parser.add_argument("--fuel-r", type=float, default=0.410, help="燃料半径(cm)")
	parser.add_argument("--gas-r", type=float, default=0.418, help="气隙外半径(cm)")
	parser.add_argument("--clad-r", type=float, default=0.475, help="包壳外半径(cm)")

	parser.add_argument("--fuel-rods", type=int, default=264, help="单组件燃料棒数量")
	parser.add_argument("--active-height-cm", type=float, default=365.0, help="有效高度(cm)")
	parser.add_argument(
		"--assembly-mass-kg",
		"--assembly-hm-kg",
		dest="assembly_mass_kg",
		type=float,
		default=498.7,
		help="单组件燃料混合物总质量(kg)，包含Th/U/O",
	)
	parser.add_argument("--fuel-mat-dens", type=float, default=9.8, help="卡片中的燃料材料密度(g/cm3)")

	parser.add_argument(
		"--audit-csv",
		default="hm_loading_audit.csv",
		help="输出审计CSV（用于核对每个算例反算密度与回代质量）",
	)
	return parser.parse_args()


def ace_suffix_for_temp(temp_k: int) -> str:
	if temp_k == 800:
		return "06c"
	if temp_k in (900, 1000):
		return "09c"
	raise ValueError(f"不支持的温度: {temp_k}")


def hm_average_molar_mass(frac: dict[str, float]) -> float:
	return (
		frac["th232"] * 232.0
		+ frac["u233"] * 233.0
		+ frac["u235"] * 235.0
		+ frac["u238"] * 238.0
		+ frac["pu239"] * 239.0
	)


def oxide_molar_mass(frac: dict[str, float]) -> float:
	"""返回每个 HM 原子对应的氧化物摩尔质量，单位 g/mol-formula。"""
	return hm_average_molar_mass(frac) + OXYGEN_ATOMS_PER_HM_ATOM * O16_MOLAR_MASS


def hm_number_fractions(
	th_frac: float,
	pu_frac: float,
	u235_enrichment: float,
	u233_frac: float,
) -> dict[str, float]:
	for name, value in (
		("Th_level", th_frac),
		("Pu_level", pu_frac),
		("U235_enrichment", u235_enrichment),
		("U233_enrichment", u233_frac),
	):
		if value < -1.0e-8 or value > 1.0 + 1.0e-8:
			raise ValueError(f"{name} 超出[0,1]范围: {value}")

	u_total = 1.0 - th_frac - pu_frac - u233_frac
	if u_total < -1.0e-8:
		raise ValueError(
			"Th/Pu/U233 原子分数之和超过 1，无法分配 U 组分: "
			f"Th={th_frac}, Pu={pu_frac}, U233={u233_frac}"
		)
	if u_total < 0.0:
		u_total = 0.0

	u235 = u_total * u235_enrichment
	u238 = u_total - u235

	return {
		"th232": th_frac,
		"u233": u233_frac,
		"pu239": pu_frac,
		"u235": u235,
		"u238": u238,
	}


def infer_fissile_type(frac: dict[str, float]) -> str:
	has_u233 = frac["u233"] > 0.0
	has_pu = frac["pu239"] > 0.0
	has_u235 = frac["u235"] > 0.0
	if has_u233 and not has_pu and not has_u235:
		return "U233"
	if has_pu and not has_u233 and not has_u235:
		return "Pu239"
	if has_pu and has_u235:
		return "Pu239+U235"
	if has_u235:
		return "U235"
	return "Other"


def parse_case_row(row: dict[str, str]) -> dict[str, Any]:
	if "fissile_type" in row and "enrich_mode" in row:
		th_frac = float(row["Th_level"])
		fissile_type = row["fissile_type"].strip()
		fissile_enr = float(row["enrich_mode"])
		if fissile_type == "U235":
			frac = hm_number_fractions(th_frac, 0.0, fissile_enr, 0.0)
		elif fissile_type == "U233":
			frac = hm_number_fractions(th_frac, 0.0, 0.0, fissile_enr)
		elif fissile_type == "Pu239":
			frac = hm_number_fractions(th_frac, fissile_enr, 0.0, 0.0)
		else:
			raise ValueError(f"不支持的fissile_type: {fissile_type}")
		return {
			"case_id": row.get("case_id", ""),
			"th_frac": th_frac,
			"pu_frac": frac["pu239"],
			"u233_frac": frac["u233"],
			"u235_enrichment": fissile_enr if fissile_type == "U235" else 0.0,
			"fractions": frac,
			"fissile_type": fissile_type,
		}

	th_frac = float(row["Th_level"])
	pu_frac = float(row["Pu_level"])
	u235_enr = float(row["U235_enrichment"])
	u233_frac = float(row["U233_enrichment"])
	frac = hm_number_fractions(th_frac, pu_frac, u235_enr, u233_frac)
	return {
		"case_id": row.get("case_id", ""),
		"th_frac": th_frac,
		"pu_frac": pu_frac,
		"u233_frac": u233_frac,
		"u235_enrichment": u235_enr,
		"fractions": frac,
		"fissile_type": infer_fissile_type(frac),
	}


def back_calculate_hm_atom_dens(
	target_mass_kg: float,
	fuel_r_cm: float,
	active_height_cm: float,
	fuel_rods: int,
	frac: dict[str, float],
) -> float:
	if target_mass_kg <= 0.0:
		raise ValueError("assembly mass must be positive")
	if fuel_rods <= 0:
		raise ValueError("燃料棒数量必须为正")

	total_fuel_volume_cm3 = fuel_rods * math.pi * (fuel_r_cm ** 2) * active_height_cm
	formula_molar_mass = oxide_molar_mass(frac)
	target_mass_g = target_mass_kg * 1.0e3

	return (target_mass_g * AVOGADRO) / (formula_molar_mass * total_fuel_volume_cm3 * ATOMS_PER_ATOM_B_CM)


def hm_mass_from_atom_dens(
	hm_atom_dens: float,
	fuel_r_cm: float,
	active_height_cm: float,
	fuel_rods: int,
	frac: dict[str, float],
) -> float:
	total_fuel_volume_cm3 = fuel_rods * math.pi * (fuel_r_cm ** 2) * active_height_cm
	avg_molar_mass = oxide_molar_mass(frac)
	atoms = hm_atom_dens * ATOMS_PER_ATOM_B_CM * total_fuel_volume_cm3
	grams = atoms * avg_molar_mass / AVOGADRO
	return grams / 1.0e3


def isotope_densities(hm_atom_dens: float, frac: dict[str, float]) -> dict[str, float]:
	return {
		"o16": OXYGEN_ATOMS_PER_HM_ATOM * hm_atom_dens,
		"th232": hm_atom_dens * frac["th232"],
		"u233": hm_atom_dens * frac["u233"],
		"pu239": hm_atom_dens * frac["pu239"],
		"u235": hm_atom_dens * frac["u235"],
		"u238": hm_atom_dens * frac["u238"],
	}


def material_block(
	temp_k: int,
	hm_atom_dens: float,
	frac: dict[str, float],
	fuel_mat_dens: float,
) -> str:
	d = isotope_densities(hm_atom_dens, frac)
	ace = ace_suffix_for_temp(temp_k)

	lines = [
		f"mat fuel  -{fuel_mat_dens:.3f} tmp {temp_k} burn 1 rgb 200 50 50",
		f"8016.{ace}   {d['o16']:.8e}",
		f"90232.{ace}  {d['th232']:.8e}",
	]
	if d["u233"] > 0.0:
		lines.append(f"92233.{ace}  {d['u233']:.8e}")
	if d.get("pu239", 0.0) > 0.0:
		lines.append(f"94239.{ace}  {d['pu239']:.8e}")
	if d["u235"] > 0.0:
		lines.append(f"92235.{ace}  {d['u235']:.8e}")
	lines.append(f"92238.{ace}  {d['u238']:.8e}")
	return "\n".join(lines)


def make_homo_lattice(n: int = 17) -> str:
	grid = [[12 for _ in range(n)] for _ in range(n)]
	for r, c in GUIDE_TUBE_POSITIONS:
		if 0 <= r < n and 0 <= c < n:
			grid[r][c] = 21
	return "\n".join(" ".join(str(v) for v in row) for row in grid)


def apply_template(template: str, values: dict[str, str]) -> str:
	out = template
	for k, v in values.items():
		out = out.replace(f"{{{{{k}}}}}", v)
	return out


def case_name(group_prefix: str, ordinal: int) -> str:
	return f"{group_prefix}{ordinal:03d}"


def main() -> None:
	args = parse_args()

	template_text = Path(args.template).read_text(encoding="utf-8")
	out_root = Path(args.output_root)
	out_root.mkdir(parents=True, exist_ok=True)

	lattice_map = make_homo_lattice()

	audit_rows: list[dict[str, str]] = []
	group_counters: dict[str, int] = {"U235": 0, "U233": 0, "Pu239": 0, "Other": 0}
	group_prefix_map = {"U235": "A", "U233": "B", "Pu239": "C", "Other": args.case_prefix}

	with Path(args.csv).open("r", encoding="utf-8", newline="") as f:
		rows = list(csv.DictReader(f))

	for row in rows:
		parsed = parse_case_row(row)
		th_frac = float(parsed["th_frac"])
		pu_frac = float(parsed["pu_frac"])
		u233_frac = float(parsed["u233_frac"])
		u235_enr = float(parsed["u235_enrichment"])
		frac = parsed["fractions"]
		fissile_type = str(parsed["fissile_type"])

		row_case_id = str(parsed["case_id"]).strip()
		if row_case_id:
			cname = row_case_id
		else:
			if fissile_type not in group_counters:
				group_counters["Other"] += 1
				cname = case_name(group_prefix_map["Other"], group_counters["Other"])
			else:
				group_counters[fissile_type] += 1
				cname = case_name(group_prefix_map[fissile_type], group_counters[fissile_type])

		hm_atom_dens = back_calculate_hm_atom_dens(
			target_mass_kg=args.assembly_mass_kg,
			fuel_r_cm=args.fuel_r,
			active_height_cm=args.active_height_cm,
			fuel_rods=args.fuel_rods,
			frac=frac,
		)

		fuel_block = material_block(
			temp_k=args.temp,
			hm_atom_dens=hm_atom_dens,
			frac=frac,
			fuel_mat_dens=args.fuel_mat_dens,
		)

		case_dir = out_root / cname
		case_dir.mkdir(parents=True, exist_ok=True)
		outfile_path = str((case_dir / cname).resolve())

		values = {
			"CASE_ID": cname,
			"TITLE": (
				f"{cname}_homo_{fissile_type}_"
				f"Th{th_frac:.3f}_Pu{pu_frac:.3f}_U233{u233_frac:.3f}_U235E{u235_enr:.5f}"
			),
			"ACELIB": args.acelib,
			"DECLIB": args.declib,
			"NFYLIB": args.nfylib,
			"TEMP": str(args.temp),
			"ACE_SUFFIX": ace_suffix_for_temp(args.temp),
			"FUEL_MATERIAL_BLOCK": fuel_block,
			"PIN_DEFINITIONS": (
				"pin 12\n"
				f"fuel     {args.fuel_r:.3f}\n"
				f"gas      {args.gas_r:.3f}\n"
				f"clad     {args.clad_r:.3f}\n"
				"water"
			),
			"PIN_PITCH": f"{args.pin_pitch:.3f}",
			"LATTICE_MAP": lattice_map,
			"OUTFILE_PATH": outfile_path,
		}

		text = apply_template(template_text, values)
		text = apply_template(text, values)
		out_file = case_dir / f"{cname}.sss"
		out_file.write_text(text, encoding="utf-8")

		mixture_mass_check = hm_mass_from_atom_dens(
			hm_atom_dens=hm_atom_dens,
			fuel_r_cm=args.fuel_r,
			active_height_cm=args.active_height_cm,
			fuel_rods=args.fuel_rods,
			frac=frac,
		)

		audit_rows.append(
			{
				"case_id": row.get("case_id", cname),
				"case_name": cname,
				"th_frac": f"{th_frac:.3f}",
				"pu_frac": f"{pu_frac:.3f}",
				"u233_frac": f"{u233_frac:.3f}",
				"u235_enrichment": f"{u235_enr:.5f}",
				"fissile_type": fissile_type,
				"fissile_enr": f"{u235_enr:.5f}",
				"hm_atom_dens": f"{hm_atom_dens:.8e}",
				"hm_mass_check_kg": f"{mixture_mass_check:.6f}",
				"hm_mass_error_kg": f"{(mixture_mass_check - args.assembly_mass_kg):.6e}",
			}
		)

		print(f"[OK] generated {out_file}")

	audit_path = Path(args.audit_csv)
	with audit_path.open("w", encoding="utf-8", newline="") as f:
		writer = csv.DictWriter(
			f,
			fieldnames=[
				"case_id",
				"case_name",
				"th_frac",
				"pu_frac",
				"u233_frac",
				"u235_enrichment",
				"fissile_type",
				"fissile_enr",
				"hm_atom_dens",
				"hm_mass_check_kg",
				"hm_mass_error_kg",
			],
		)
		writer.writeheader()
		writer.writerows(audit_rows)

	print(f"[OK] wrote audit CSV: {audit_path.resolve()}")


if __name__ == "__main__":
	main()
