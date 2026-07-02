# MCP / External-Tool Session Log

V5 provenance record for artifacts generated or modified by external tools.
Required before claiming any artifact came from OpenSCAD, Blender, Illustrator,
Photoshop, Fusion, SketchUp, or similar tooling.

| session_id | tool | input_authority | outputs | role | authority_result | review_status | notes |
|---|---|---|---|---|---|---|---|
| fable-v5-refresh-2026-07-01 | claude-code (Fable 5) | Drone-Flutes-Design.xlsx, family-spec.csv | bom.csv, sourcing.csv, cut-list.csv, validation.csv, shop-validation-gates.csv, family-spec.csv, Drone-Flutes-Design.xlsx | packet_refresh | fabrication | self_checked | V5 refresh pass: tabular packet data reviewed against family-spec.csv / design table baseline; no dimension changes made. Provenance rows added to satisfy V5 fabrication-artifact logging. |
| fable-v5-refresh-2026-07-01 | claude-code (Fable 5) + OpenSCAD CLI | family-spec.csv, design.md, drone-flutes-starter.wl (formula mirror), bom.csv row 3.5 | cad/drone-flutes.scad | cad_authoring | pending_measurement | self_checked | First parametric master for this repo: melody-bore + drone-bore + octagon body/facet envelope, equation-driven pentatonic-minor tone-hole schedule (design.md hole formula). Duct/fipple/window/voicing geometry explicitly out of scope (see header). Bore-to-bore offset flagged TBD/assumption — not in any source table. Tone-hole diameter per member is an ascending-bore-order assumption from bom.csv row 3.5 (brad-point set not member-tagged in source). OpenSCAD render check: pass for all 4 members (openscad -o STL, exit 0). |
| fable-v5-refresh-2026-07-01 | claude-code (Fable 5) | Drone-Flutes-Design.xlsx (Master_Inputs mirror) | drone-flutes-starter.wl | analysis_source | derived_preview | unreviewed | Pre-existing Wolfram source, deployed read-only to Wolfram Cloud (Public-Execute) and embedded live in explorer.html. Not re-executed or modified this pass — source-only, L2 evidence. Register row added (WL-001). |
