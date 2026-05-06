# Drone Flute Family — Printable Shop Packet

Print this from the shop computer. Sections page-break for shop-floor reading.

---

## 1. Cover / Project Summary

**Project:** Drone Flute Family (DRN-FAM-001)
**Date:** 2026-05-05
**Builder:** Tony Koop
**Shop:** Maker Nexus, South Bay
**Materials cost:** $193 (walnut + maple) plus $245 one-time tooling = $438 first build, $193 every build after

A four-member family of Native American style drone flutes in keys Am, F#m, Em, Dm. Walnut bodies with hard-maple CNC inlay. Each flute has a separate drone chamber and ships with three swappable drone blocks (unison, fifth-below, octave-below).

---

## 2. Quick Start + File Map

1. Confirm walnut and maple stock are acclimated (7 days minimum).
2. Open `Drone-Flutes-Design.xlsx` — verify Master_Inputs match shop temp + concert pitch.
3. Open `cut-list.csv` — print and tape to the bandsaw.
4. Phase 1 (stock prep) → Phase 12 (tuning + photos) per `assembly-manual.md`.

Files in this packet:
- `Drone-Flutes-Design.xlsx` — source of truth
- `assembly-manual.md` — shop-floor build steps
- `cut-list.csv` — bandsaw + lathe cuts
- `bom.csv` — what to order
- `validation.csv` — tuning targets
- `drawings/` — per-key SVG drawings
- `inlay-patterns/` — DXFs for V-Carve
- `cnc/` — generated G-code (after CAM)
- `sw-reference/Drone-Flutes-SolidWorks-MasterLayout.docx` — CAD setup

---

## 3. Design Intent + Assumptions

- Open-open pipe physics with NAF K2 empirical correction.
- A=440 Hz concert pitch.
- 68°F shop reference temperature.
- Octagonal exterior (8 facets) for 8 inlay panels per body.
- Walnut is the body wood across all 4 flutes.
- Maple is the inlay wood across all 4 flutes.
- Drone offset is unison by default (matches melody fundamental).

Assumptions worth flagging:
- The K2 piecewise table is from 150+ NAF measurements on past flutes. New family, similar bore range — likely accurate within ±3 cents but verify on flute 1 before mass-finishing.
- Faceting allowance is 0.05"; this is conservative. If chatter on the lathe is bad, raise to 0.07".

---

## 4. BOM (paste of bom.csv with totals)

Wood subtotal: $193
Hardware + finish: $78
CNC tooling + drills (one-time): $245
Files: free

**Total first build: $516. Subsequent builds: $271.**

Full BOM in `bom.csv`. Print and bring to lumber yard / Bell Forest / IDC Woodcraft.

---

## 5. Sourcing List

See `sourcing.csv` for all suppliers + URLs + lead times. RFQ drafts in `supplier-rfq.md`.

---

## 6. Cut List + Stock Yield

See `cut-list.csv`. Highlights:
- 4 walnut body blanks (one per key, two sizes)
- 1 walnut block stick → 12 drone blocks (3 per flute × 4 flutes)
- 1 walnut offcut → 4 bird blocks
- 2 sheets 1/16" maple → all band inlay plugs
- 1 sheet 1/8" maple → all feature panel plugs

Yield: ~85% on bodies, ~95% on drone blocks, ~80% on inlay maple (lots of small pieces).

---

## 7. Drawings + Critical Dimensions

Drawings in `drawings/`:
- `Am.svg`, `Fsm.svg`, `Em.svg`, `Dm.svg` — per-key plan + section
- `assembly.svg` — exploded view (F#m canonical)
- `family-overview.svg` — all 4 to scale

**Critical tolerances:**
- Hole positions: ±0.020" (tuning-critical)
- Drone tenon: ±0.003" (fit-critical)
- Wall thickness at bore: ≥ 0.20" (structural minimum)
- Window splitting edge: knife-sharp (no measurement; listen-test)
- Inlay plug flush: < 0.005" proud or recessed
- Glue line: no visible gap

---

## 8. Assembly Manual

Full version in `assembly-manual.md`. Phase summary:

| Phase | Day | Focus |
|---|---|---|
| 1 | 1-7 | Stock prep + acclimation |
| 2 | 8-9 | Split-body CNC |
| 3 | 10 | Glue-up (24h cure) |
| 4 | 12 | Lathe rounding |
| 5 | 13 | CNC faceting |
| 6 | 14 | Tone holes + tune |
| 7 | 15 | Window + splitting edge |
| 8 | 16-22 | Inlay (24 ops/flute) |
| 9 | 23-24 | Drone blocks (12 total) |
| 10 | 25 | Bird blocks (4) |
| 11 | 26-31 | Finish (Tru-Oil 4-6 coats) |
| 12 | 38-42 | Cure + tune + photos |

---

## 9. Validation / Tuning Sheet

Predictions in `validation.csv`. Per-flute targets:

| Member | f0 (Hz) | h1 m3 | h2 P4 | h3 P5 | h4 m6 | h5 m7 | h6 oct |
|---|---|---|---|---|---|---|---|
| Am | 440.0 | 523.3 | 587.3 | 659.3 | 698.5 | 783.99 | 880.0 |
| F#m | 370.0 | 440.0 | 493.9 | 554.4 | 587.3 | 659.3 | 740.0 |
| Em | 329.6 | 392.0 | 440.0 | 493.9 | 523.3 | 587.3 | 659.3 |
| Dm | 293.7 | 349.2 | 392.0 | 440.0 | 466.2 | 523.3 | 587.3 |

Drone targets per flute = fundamental × {1, 2^(-7/12), 0.5} for the three blocks.

Tolerance: ±5 cents. Record measured Hz + cents error in `validation.csv`.

---

## 10. Supplier RFQ

Three RFQ drafts in `supplier-rfq.md`. Adapt the contact info and dates.

---

## 11. Visual BOM Brief

Layout spec in `visual-bom-brief.md`. Render `images/visual-bom.png` after photoshoot.

---

## 12. Appendix

- Raw formula reference: `wolfram-starter.wl`
- Capstone manifest: `capstone-manifest.json`
- Cross-references to sister repos: `flutes`, `fujara`, `transverse-flute`, `shakuhachi`
- This packet on the web: `site/index.html`
- License: see `LICENSE`
