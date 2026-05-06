# Drone Flute Family — Parametric Design (v4)

**Packet:** DRN-FAM-001
**Family:** open-pipe (Native American Flute lineage; drone-flute variant)
**Pipeline:** cnc-lathe (hybrid: split-body CNC + lathe round + CNC facet)
**Status:** in-progress
**Sisters:** [flutes](https://github.com/tonykoop/flutes), [fujara](https://github.com/tonykoop/fujara), [transverse-flute](https://github.com/tonykoop/transverse-flute), [shakuhachi](https://github.com/tonykoop/shakuhachi)
**Done-bar reference:** `flutes` (NAF family with K2 corrections)
**Aesthetic references:** elementalflutes.com/gallery, broinwood.com (CNC inlay)
**Date:** 2026-05-05

## What this is

A four-member family of Native American style **drone flutes** (each flute has both a melodic side and a separate sustained-drone chamber sharing the same body). Keys: Am, F#m, Em, Dm. Bodies are walnut, inlay is hard maple. The drone block is **swappable** — three blocks ship per flute (unison, perfect fifth below, octave below) so the player can change the drone without retuning the melody side.

This is the same parametric workflow Tony uses for the rest of the open-pipe woodwinds (`flutes`, `fujara`, `transverse-flute`): an Excel `Master_Inputs` sheet with named global variables drives the `Design_Table`; SolidWorks reads from the same Excel via a linked design table; CNC G-code is generated in V-Carve from SolidWorks-exported DXFs.

## Governing model

Open-open pipe with end corrections and Tony's empirical NAF K2 bore-size correction.

```
f = c / (2 · L_eff)
L_eff = L_acoustic_corrected = (c / (2 · f)) · (1 + K2(bore_ID))
L_bore_physical = L_acoustic_corrected − 2 · k_end · (bore_ID / 2)
```

- `c` = 13,552 in/s at 68°F
- `k_end` = 0.6 (open-end correction multiplier, applied at each open end)
- `K2(bore_ID)` is a piecewise lookup: −2.0 % for bore < 0.75 in, −0.7 % for 0.75–0.875, +0.4 % for 0.875–1.0, +0.7 % for 1.0–1.125, +1.3 % for ≥ 1.125 in. Source: 150+ NAF measurements (Tony's empirical dataset).

Hole positions (from foot, m3 closest to foot, octave farthest):

```
pos_from_foot = L_acoustic_corrected · (1 − f_fundamental / f_hole)
```

Pentatonic minor scale (NAF Mode 1/4): semitone offsets `[+3, +5, +7, +8, +10, +12]` from the fundamental.

The drone chamber is a separate parallel bore in the same body; it has its own `bore_ID`, its own K2 correction, and its own `L_acoustic`. The drone block tenon-fits into a socket at the foot end; three blocks per flute provide unison / fifth-below / octave-below tunings via different cavity lengths.

## Family scaling law

For a given pitch class (minor) and same drone-offset configuration, all member dimensions follow the open-pipe relationship `L ∝ 1/f`. Choosing bore_ID per key keeps the chamber-to-bore ratio inside Tony's 17–21 sweet spot (denser air column for lower keys, narrower bore for higher keys).

| Member | Key | Fund. (Hz) | Bore ID | L_total | Chamber:bore |
|---|---|---|---|---|---|
| DRN-Am  | Am  | 440.0 | 0.750" | 21.97 in | 20.4 |
| DRN-Fsm | F#m | 370.0 | 0.875" | 24.99 in | 21.0 |
| DRN-Em  | Em  | 329.6 | 1.000" | 27.23 in | 20.7 |
| DRN-Dm  | Dm  | 293.7 | 1.125" | 29.82 in | 20.8 |

See `family-spec.csv` for the row-per-member spec the auto-generators read.

## Parametric design surface

Source of truth for all numbers: **`Drone-Flutes-Design.xlsx`** (Master_Inputs sheet). Blue cells are user-editable inputs; black cells are formulas. SolidWorks reads from the Design_Table sheet via the linked design table — see `sw-reference/Drone-Flutes-SolidWorks-MasterLayout.docx`.

Key inputs (edit these to retarget the family):

- `c_speed_of_sound` (in/s) — adjust for shop temperature
- `A4_reference` (Hz) — concert pitch; 440 by default, can change to 432
- `MIDI_note` per column — defines each member's fundamental
- `bore_ID` per column — drives K2 and chamber:bore ratio
- `drone_offset_st` — global; flips all four flutes between unison/5th/octave drones
- `n_facets` — octagon by default; can change to hex (6) or dodecagon (12)
- Inlay parameters — band positions, depths, plug oversize

## Construction summary

Hybrid build:

1. **Split-body CNC** — bandsaw the blank in half along the long axis, route the bore profile and SAC pocket on each half, glue back. This is the only practical way to put a precision bore in a long blank with the ShopBot.
2. **Lathe rounding** — turn glued blank to `body_OD_round` (which includes a `facet_allowance` for the next step).
3. **CNC faceting** — V-block jig, eight 22.5° rotations, flatten each facet on the ShopBot to bring `body_OD_flat` to spec. This produces eight flat faces for inlay.
4. **CNC inlay** — chevron (band 1, 2), diamond (band 3), constellation+arrow (feature panel) per `inlay-patterns/{key}/`.
5. **Drone block set** — three lathe-turned blocks per flute (unison/5/8). Tenon engagement length 0.75", 0.005" slip-fit clearance.

## Validation strategy

Each finished flute is tuned with a chromatic tuner against the predicted frequencies in `validation.csv`. Cents error is recorded; deviations >5 cents trigger a hole-recutting decision (file the foot edge to lower, fill the bird edge to raise). Measured data feeds back into `validation.csv` and through `record_measurement.py` into Tony's per-family corrections database (eventually).

## Open assumptions

- A=440 reference. Change `A4_reference` for 432 or HIPP tunings.
- 68°F shop reference. The walnut-glue cure window assumes this.
- Octagon (8 facets). The same workbook supports 6 or 12 by changing `n_facets`.
- Walnut + maple as the wood pair. `Wood_Library` sheet lists alternates with E, ρ, Janka.
- Single concert-pitch tuning for all four flutes. Could split-tune (e.g., F#m and Dm at A=440 for solo, Em and Am at A=432 for ensemble work).
