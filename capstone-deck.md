# Drone Flute Family — Capstone Deck

Slide-by-slide outline. Renders to `capstone-deck.pptx` via `python-pptx`.

# Title

Drone Flute Family · DRN-FAM-001
Walnut + Maple · 4 keys · Tunable drone block set
Tony Koop · Maker Nexus · 2026-05-05

# Project Intent

A four-member family of Native American style drone flutes (Am, F#m, Em, Dm) inspired by elementalflutes.com gallery. Each flute has a separate drone chamber with three swappable drone blocks (unison, fifth, octave). Goal: ship a publishable build packet that another maker could rebuild from these files.

# File Map

- `Drone-Flutes-Design.xlsx` — parametric source of truth (284 formulas, 6 sheets)
- `design.md` — physics + family scaling write-up
- `bom.csv` / `sourcing.csv` / `cut-list.csv` / `validation.csv` — structured data
- `assembly-manual.md` / `supplier-rfq.md` / `visual-bom-brief.md` / `drawing-brief.md` — markdown briefs
- `risks.md` — red-team failure-mode walk
- `wolfram-starter.wl` — interactive Wolfram notebook
- `drawings/` — 4 dimensioned SVG drawings + assembly + family-overview
- `inlay-patterns/` — 16 DXF + 16 SVG inlay patterns (4 per key × 4 keys)
- `sw-reference/` — SolidWorks master layout reference
- `site/` — recruiter-facing static site

# Build Workflow

design (Excel + SW) → source (BOM/sourcing/RFQ) → cut (cut-list) → fixture (V-block jig) → split-body CNC → glue → lathe → facet → holes → window → inlay → drone blocks → bird → finish → tune → validate

# Design Sheet Highlights

- A4 = 440 Hz reference; switchable to 432 in one cell.
- K2 piecewise correction by bore ID; 5 segments from −2.0 % to +1.3 %.
- Chamber:bore ratio held in 17–21 across all keys (Am 20.4, F#m 21.0, Em 20.7, Dm 20.8).
- Drone offset is a global semitone variable; flips all 4 flutes between U / 5 / 8 in one edit.

# BOM Snapshot

Material total: $193 walnut + maple. Tooling total: $245 (one-time). Hardware/finish: $78. Grand total: $516 for the family.

Walnut bodies (4) + drone block stock (12 from 1 stick) + maple inlay (3 sheets) + finish (Tru-Oil + carnauba) + 6 CNC bits + 8 drill/Forstner.

# Drawings · CAD · CNC

Per-member SVG drawings in `drawings/{Am,Fsm,Em,Dm}.svg` — title block, plan + side + section views, datum chain (foot → window → drone socket), tolerance bands. Family-overview SVG shows all 4 to scale.

CNC G-code is generated in V-Carve from SolidWorks DXFs. ShopBot toolpaths: bore profile (1/4 downcut), facet (1/2 downcut), inlay (1/16 upcut), splitting edge (1/16 upcut climb cut).

# Visual BOM

`images/visual-bom.png` — 11×17 plate, hero + spreadsheet + sub-assembly callouts. Reference: ashiko-drum-workshop visual BOM.

# Assembly Manual Quick Reference

12 phases, 8-week calendar:
- Wk 1: stock prep + acclimation
- Wk 2: split-body CNC + glue
- Wk 3: lathe + faceting + holes + window
- Wk 4: inlay (24 ops/flute)
- Wk 5: drone blocks (12 total) + birds
- Wk 6: finish (Tru-Oil)
- Wk 7: cure
- Wk 8: tune + validate + photos

# Validation

Per-flute, per-note tuning checked vs `validation.csv` predictions. Pass band: ±5 cents. Drone chamber tested as independent (A-2 risk). Wall thickness verified ≥ 0.20" structural minimum.

# Open Risks

Top 3 from `risks.md`:
- A-1: Hole 6 (octave) prone to running sharp
- A-2: Drone-melody chamber leak (high severity, glue-up critical)
- E-1: Em/Dm hand reach for 5th-percentile players

# Next Actions

1. Order BOM (RFQ drafts ready in `supplier-rfq.md`).
2. Acclimate walnut blanks 7 days before machining.
3. Generate finalized G-code from SolidWorks design table after blanks arrive.
4. Build, tune, photograph.
5. Record measurements through `record_measurement.py` to feed the per-family corrections.
