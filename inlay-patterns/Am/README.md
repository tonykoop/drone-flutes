# Am drone flute — inlay artwork

Inlay files are sized to fit ONE facet of the Am flute. Eight identical bands wrap around the body (one per facet); the feature panel goes on a single chosen facet.

## Per-facet dimensions (this key)

| Item | Value |
|------|-------|
| facet_side_length | 0.497 in |
| facet_inset | 0.100 in (each side) |
| inlay_band_width | 0.297 in |
| band_height | 0.500 in |
| feature_panel_width | 0.297 in |
| feature_panel_height | 7.029 in |
| L_total (full flute) | 21.967 in |

## Files

| File | Purpose | Pocket depth |
|------|---------|--------------|
| `band1_chevron.svg` / `.dxf` | Lowest band (15% from foot) — chevron pattern | 0.060 in |
| `band2_chevron.svg` / `.dxf` | Center band (50%) — chevron pattern | 0.060 in |
| `band3_diamond.svg` / `.dxf` | Upper band (82%, just below bird) — diamond pattern | 0.060 in |
| `feature_constellation.svg` / `.dxf` | Feature panel (one facet, between band2 & band3) | 0.080 in |

Plug stock = 1/16" hard maple. Plug profile is the same DXF — V-Carve uses an inside offset of -0.001" for the pocket and outside offset of +0.0010" for the plug to create a 0.002" interference fit.

## DXF layers

- `POCKET_OUTLINE` — the rectangular pocket boundary (cut on profile pass)
- `CHEVRON` / `DIAMOND` / `STARS` / `ARROW` — engraved or cut-through detail lines
- `GUIDE` — visual reference only; do NOT machine

## Origin convention

DXFs anchor at (0,0) bottom-left so they import directly into V-Carve at the band y-offset given by Inlay_Layout sheet in the Excel workbook.

## CNC strategy

Use 1/16" upcut spiral. Spindle 18000 rpm, feed 60 ipm, plunge 20 ipm. Run pocket pass first; do plug profile cut on a separate fixture using maple stock.
