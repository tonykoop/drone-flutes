# CAD Starter Notes

`drone-flutes.scad` is the first parametric master for this repo. Authority:
`pending_measurement` — see `visual-output-register.csv` CAD-001 and
`mcp-session-log.md`. No placeholder existed before this pass; there was no
`cad/` directory in the checkout prior to 2026-07-01.

Scope: melody-bore envelope, parallel drone-bore envelope, octagonal body
facet reference envelope, and the six pentatonic-minor tone-hole positions
(equation-driven from `design.md`'s governing model, the same way fret slots
are equation-driven elsewhere in this cluster). All four family members
(Am, F#m, Em, Dm) are selectable via the `member` parameter and each renders
clean in OpenSCAD.

Out of scope (per `dxf-shop-authority.md` and the woodwind addendum): SAC
chamber, splitting-edge/window profile, bird-block/flue-gap voicing, tone-hole
undercut/counterbore, and drone-socket tenon fit. These are hand-refined,
tuning-sensitive regions and are not modeled here — do not treat this master
as a substitute for the reviewed body/bore/tone-hole/drone-block DXF or CAD
exports that `dxf-shop-authority.md` still lists as missing (DXF-REV-001,
FAB-BORE-009 remain blocked).

Known open items carried in the header comment of the .scad itself:
- Melody-bore-to-drone-bore centerline offset is not in `family-spec.csv` or
  `design.md` — exposed as a top-level TBD/assumption parameter, not fact.
- Tone-hole diameter per member is inferred from `bom.csv` row 3.5's four
  brad-point sizes in ascending-bore order; the source row does not tag each
  size to a member, so treat this as an assumption pending review.
