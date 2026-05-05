# Inlay Patterns — Drone Flute Set

This folder contains CNC inlay artwork for all four drone flutes (Am, F#m, Em, Dm).

Each subfolder is sized to that key's facet dimensions (a smaller flute = narrower facets = smaller artwork). All files anchor at origin (0,0) bottom-left for direct import into V-Carve.

## Per-key dimension summary

| Key | Band width × height | Feature panel width × height |
|-----|---------------------|------------------------------|
| Am | 0.297 × 0.500 in | 0.297 × 7.029 in |
| F#m | 0.349 × 0.500 in | 0.349 × 7.996 in |
| Em | 0.401 × 0.500 in | 0.401 × 8.712 in |
| Dm | 0.452 × 0.500 in | 0.452 × 9.544 in |

## File pairs

For each key:
- `band1_chevron` / `band2_chevron` — repeating chevron pattern (lower + center bands)
- `band3_diamond` — diamond + corner dot pattern (upper band, just below the bird block)
- `feature_constellation` — stylized 7-star constellation with directional arrow (single feature panel per flute)

Each pattern has both `.svg` (preview) and `.dxf` (CAM import) versions.

## Recommended toolpath strategy

1. **Pocket pass** — 1/16" upcut spiral, 18000 rpm, 60 ipm. Depth: 0.060" for bands, 0.080" for feature panels.
2. **Plug pass** — same bit on separate maple stock fixture. Outside offset +0.001" to create interference fit.
3. **Glue & flush sand** — Starbond thin CA, then 220-grit flat block.

See `Drone-Flutes-BOM-Build-Method.docx` Phase 8 for the full inlay procedure.
