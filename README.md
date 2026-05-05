# Drone Flutes — Native American Style, Set of Four

A four-flute set in **F#m, Em, Dm, Am** — pentatonic minor (Mode 1/4) — built in **walnut with hard maple inlay**. Each flute has a **drone bore** alongside the melody bore so a single block-and-pair lacing produces both a sustained drone and a six-hole pentatonic melody. Three drone blocks per flute (unison, fifth, octave) let the voicing shift inside the same key.

Inspired by the gallery work of [Elemental Flutes](https://elementalflutes.com/) and the CNC-inlay aesthetic of [Broinwood](https://www.instagram.com/broinwood/).

> *Hero image placeholder — replace `images/hero.jpg` with the four-flute group shot once finished.*

---

## What's in this repo

| File | Purpose |
|---|---|
| [`Drone-Flutes-Design.xlsx`](Drone-Flutes-Design.xlsx) | Parametric design workbook. 6 sheets — Master_Inputs, Design_Table, Hole_Schedule, Wood_Library, Inlay_Layout. **Edit blue cells only**; everything else is a formula. |
| [`Drone-Flutes-BOM-Build-Method.docx`](Drone-Flutes-BOM-Build-Method.docx) | Bill of materials, tools, toolpath table, and 13-phase build method. The shop-facing reference — print this and walk into the shop with it. |
| [`sw-reference/Drone-Flutes-SolidWorks-MasterLayout.docx`](sw-reference/Drone-Flutes-SolidWorks-MasterLayout.docx) | SolidWorks master-layout reference. 38 global variables in snake_case identical to the Excel `Master_Inputs` sheet. Configurations are per-key only (Am, F#m, Em, Dm). |
| [`inlay-patterns/`](inlay-patterns/) | CNC inlay artwork. One subfolder per key (Am, F#m, Em, Dm), each with `band1_chevron`, `band2_chevron`, `band3_diamond`, and `feature_constellation` in both `.svg` (preview) and `.dxf` (V-Carve import). |
| [`risks.md`](risks.md) | Structured risks across acoustic / structural / ergonomic / supply / fit-finish, each with a verification test attached. |

---

## How the design works

The Excel workbook is the single source of truth for dimensions. Master_Inputs holds every global variable; every other cell in the workbook references those globals via formulas. SolidWorks reads the same workbook as a design table — so editing a global in Excel rebuilds all four configurations in CAD. There are no hand-edited dimensions anywhere downstream of `Master_Inputs`.

The acoustic model is **open-open pipe** for both the melody bore and the drone bore. Hole positions come from the closed-form

```
pos_from_foot = L_acoustic_corrected · (1 − fundamental_freq / hole_freq)
```

with end corrections applied at both the foot and the window. Wall thickness, bore diameter, and chamber-to-bore ratio sit inside the empirically-validated NAF range Tony has built within for 150+ flutes.

The drone is set in semitone offsets from the fundamental (default 0 = unison). Three drone blocks per flute let the player choose:

- **Unison** — drone matches the fundamental
- **Fifth** — drone is 7 semitones below
- **Octave** — drone is 12 semitones below

Switching blocks recasts the same flute as a different musical voice without any tuning change.

---

## Build summary

The 13-phase build is in [`Drone-Flutes-BOM-Build-Method.docx`](Drone-Flutes-BOM-Build-Method.docx). High-level flow:

1. **Phase 0–1:** Design verification, stock prep, blank acclimation (7 days minimum).
2. **Phase 2–3:** Split-body CNC for bore + slow-air chamber, then glue-up.
3. **Phase 4–5:** Lathe-round body to OD, then CNC-facet to octagon (8 facets, 22.5° V-block jig).
4. **Phase 6–7:** Drill tone holes (Forstner brad-points), cut window and shape splitting edge.
5. **Phase 8:** CNC inlay — pocket + plug, 0.002" interference fit. Three bands per facet plus one feature panel.
6. **Phase 9–10:** Turn drone blocks (unison/fifth/octave) and laser-engrave bird blocks.
7. **Phase 11–12:** Finish (Tru-Oil, 4–6 coats, 7-day cure), final tuning by ear with chromatic tuner.

Estimated time: **60–80 shop hours over 4–6 weeks** (acclimation and finish cure dominate calendar time).
Estimated cost: **$516** for the set of 4 (wood + hardware + tooling already on hand at Maker Nexus).

---

## Family relationships

| Key | MIDI | f₀ (Hz) | L_total (in) | Facet side (in) |
|---|---|---|---|---|
| **Am**  | 69 | 440.0  | 21.967 | 0.497 |
| **F#m** | 66 | 369.99 | ~25.4  | 0.572 |
| **Em**  | 64 | 329.63 | ~27.6  | 0.620 |
| **Dm**  | 62 | 293.66 | 29.824 | 0.652 |

Family scaling follows open-open pipe: `L ∝ 1/f`. F#m bore is ~1.19× Am; Dm bore is ~1.36× Am.

---

## Why these four keys

Tony's playing repertoire centers on these four keys; the set covers most session work without a key change. From a build economy perspective, the four sit at musically-spaced intervals (m3 + m2 + m2) so no two are close enough to confuse, and the cumulative material order fits a single trip to lumber for walnut + maple stock.

The pentatonic minor scale (semitone offsets {0, 3, 5, 7, 10, 12}) is the NAF tradition — it is the *Mode 1/4 pentatonic* in the cross-tab `Mode 1&4 Pent.` reference sheet of `Musical Instruments V2.xlsx` and the standard layout for North American flute makers.

---

## Inlay design

Eight facets per flute means eight identical chevron bands at three vertical positions (15%, 50%, 82% from foot), plus one feature constellation panel on a single chosen facet (between band 2 and band 3, just below the bird block). Geometry is parametric to the facet width per key:

- Lower & center bands: chevron pattern, 0.060" pocket depth
- Upper band: diamond + corner-dot pattern, 0.060" depth
- Feature panel: stylized 7-star constellation with directional arrow, 0.080" depth

All artwork generates from the [`inlay-patterns/`](inlay-patterns/) folder, sized per key. Plug stock is 1/16" hard maple. Pocket is cut at -0.001" inside offset; plug at +0.001" outside offset → 0.002" interference fit. Apply thin CA glue, press, sand flush.

---

## Tooling & shop

Built at [Maker Nexus](https://www.makernexus.org/) (Sunnyvale, CA) on:
- ShopBot CNC router (4×8 bed) — bore, faceting, inlay
- 12" wood lathe — body rounding and drone blocks
- Epilog laser — bird-block totem engraving
- Drill press, bandsaw, jointer, planer, table saw, drum sander

Plus Tony's home shop:
- SolidWorks (parametric CAD with design tables)
- Vectric V-Carve (CAM for ShopBot)
- Standard hand tools, chromatic tuner

---

## Sister projects in the workshop

This drone-flute set sits alongside Tony's other instrument work at [github.com/tonykoop](https://github.com/tonykoop) — see the [`flutes`](https://github.com/tonykoop/flutes), [`fujara`](https://github.com/tonykoop/fujara), and [`tongue-drum`](https://github.com/tonykoop/tongue-drum) repos for the broader portfolio. The acoustic physics and empirical NAF corrections used here come from the [`instrument-maker`](https://github.com/tonykoop/instrument-maker) skill (v4), which encodes the K2 bore-correction table, scale-pattern conventions, and material K-constants used throughout these designs.

---

## License

MIT for the design workbook, build documentation, and inlay artwork. See [`LICENSE`](LICENSE).
