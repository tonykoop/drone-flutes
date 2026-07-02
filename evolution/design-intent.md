# Design Intent — drone-flutes rev A

- Master CAD: `cad/drone-flutes.scad` (sha256: 05f84ff9b06209cb90c3cb4582ba9f86a4075b30f41d5fecbc404bded7124ddd), driven by `family-spec.csv` (sha256: 1cfbed45703db40fa902f2bde1a24349374f9bfefdf9ba2f1b1fe5c1240d1253) and `Drone-Flutes-Design.xlsx` (sha256: d3b784c738a0f81cb7581b918f8eaa2f04b11650797b9905257d2063148a2dca)
- Function: A four-member family of Native American style drone flutes (Am, F#m, Em, Dm) — hybrid CNC + lathe + facet construction, hard maple inlay over walnut bodies. Each flute has a melody bore (open-open pipe, six pentatonic-minor finger holes) and a separate parallel drone chamber fed by one of three swappable tenon-fit drone blocks (unison / fifth-below / octave-below), so drone tuning can change without retuning the melody side.
- Environment: player-breath-driven open-pipe woodwind; walnut body is a solid-wood plate/tube assembly sensitive to humidity and glue-line integrity (risks.md S-1). Shop reference temperature 68°F (design.md).
- Target qty: 1 prototype (F#m first article per roadmap). Deadline: TBD. Budget/unit ceiling: TBD.

## Critical dimensions (carry tolerances)

| Feature | Nominal | Tolerance | Why critical | Source |
| --- | --- | --- | --- | --- |
| Bore ID (per member) | 0.750–1.125 in (Am→Dm) | drives K2 correction + chamber:bore ratio | governs fundamental pitch and voicing | family-spec.csv `bore_id_in` (measurement_required) |
| Total length (per member) | 21.97–29.82 in (Am→Dm) | body blank sizing | acoustic length sets fundamental | family-spec.csv `total_length_in` (measurement_required) |
| Tone-hole positions (6, pentatonic minor) | formula-driven, e.g. Am H1≈2.43 in from foot | drawing-brief.md: hole positions ±0.020 in | melody-side intonation | design.md governing model `pos_from_foot = L_acoustic·(1−f0/f_hole)`, cad/drone-flutes.scad echo check |
| Drone bore ID (per member) | 0.625–1.000 in (Am→Dm) | measurement_required | drone-side pitch/voicing | family-spec.csv `drone_bore_in` |
| Body OD / facet side (per member) | body_od 1.300–1.675 in; facet_side 0.497–0.652 in | shop tolerances ±0.030 in (drawing-brief.md) | wall thickness after faceting | family-spec.csv `body_od_in`, `facet_side_in` |
| Wall thickness at bore, post-facet | ≥0.20 in structural minimum | caliper check after CNC facet | crack risk if thinner (risks.md S-3) | risks.md S-3 |
| Drone-block tenon engagement / slip fit | 0.75 in engagement, 0.005 in clearance | ±0.003 in fit-critical (drawing-brief.md) | swap reliability, breakage risk (risks.md S-2) | shop-validation-gates.csv FAB-TENON-007 |
| Bore-to-bore (melody/drone) centerline offset | TBD | n/a — not yet sourced | needed for split-body CNC toolpath | NOT in family-spec.csv or design.md; exposed as `bore_offset_in` assumption in cad/drone-flutes.scad, flagged for review |

## Incidental (free for DFM)

- Octagon facet count could vary (workbook `n_facets` supports 6/8/12); inlay band/plug artwork and layout; wood species substitution within `Wood_Library` sheet alternates; bird-block/leather-lace cosmetic detail.

## Must-nots (DFM may never violate)

- Do not cut acoustic body/bore/tone-hole/drone-block geometry from anything but a reviewed CAD/DXF export matching the current workbook revision (dxf-shop-authority.md; DXF-REV-001 gate, currently blocked).
- Do not use a decorative inlay DXF to infer body length, hole location, bore geometry, drone-block cavity length, or fixture datums (dxf-shop-authority.md "Decorative Inlay Boundary").
- Do not reduce wall thickness below the 0.20 in structural minimum without recomputing crack risk (risks.md S-3).
- Do not treat `cad/drone-flutes.scad`'s tone-hole diameters or bore-to-bore offset as fabrication fact — both are explicitly flagged assumption/TBD in the file header pending a sourced value.
- Do not skip the chisel finishing pass on the splitting edge — leaving the upcut skin unfinished causes breathy tone (risks.md A-3); this geometry is out of scope for the .scad by design.

## Material intent

- Preferred: black walnut body, hard maple inlay (bom.csv rows 1.1–1.4). Tru-Oil + Howards Feed-N-Wax finish.
- Acceptable subs: cherry or mahogany for body walnut; curly maple or holly for inlay (sourcing.csv substitute_acceptable column).
- Forbidden: none recorded.

## Stage status

Stage 0 intake complete 2026-07-01. Gate A (Alpha shop compile) NOT yet run — no concessions logged, nothing presented as shippable. dxf-shop-authority.md's acoustic-body DXF/CAD export gate (DXF-REV-001) and FAB-BORE-009 remain blocked independent of this intake.
