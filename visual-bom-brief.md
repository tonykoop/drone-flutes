# Visual BOM Brief — Drone Flute Family

Reference layout: `C:\Users\Tony\Documents\GitHub\ashiko-drum-workshop\images\figure-bom-v2.png`.

## Header block

- **Title:** "Drone Flute Family — Build Resources"
- **Sub:** "DRN-FAM-001 · Walnut + Maple · ShopBot CNC + lathe + Epilog laser · Maker Nexus"
- **Quote date:** 2026-05-05
- **Estimated cost:** $516 (materials + tooling)
- **Build window:** 8 weeks total

## Hero image

Single hero showing all four finished flutes laid out from longest (Dm, ~30 in) to shortest (Am, ~22 in) on a neutral linen drop, with the swappable drone blocks fanned out in front of each flute. Bird blocks on top facets, leather laces visible.

If hero photography isn't done yet, use `images/hero-placeholder.svg` (a labelled scale outline of the four flutes side-by-side) and mark it as a placeholder.

## Spreadsheet area

Reproduce `bom.csv` as a table with these columns and a thumbnail per row:

| # | Part | Image | Qty | Spec | Material | Supplier | Unit $ | Line $ |
|---|------|-------|-----|------|----------|----------|--------|--------|

- Group rows by `category` (wood / hardware / consumables / tooling / files).
- Strong column headers, alternating row fills (#F2F2F2 / white).
- Thumbnails are 0.75 × 0.75 in. Walnut blank = stock photo; inlay maple = stock photo; bits = supplier images.
- Right-align numbers.

## Sub-assembly callouts

Three subsystem images on the right margin:
1. **Body cross-section** — exploded view showing left half / right half / drone block. Overlay the bore profile on the cross-section.
2. **Bird block** — single 3D render with leather lace.
3. **Drone block set** — three blocks (U / 5 / 8) in a row with engraved tags visible.

## Footnotes

- "All wood specs assume 6–8 % MC. Acclimate 7 days before machining."
- "Pricing dated 2026-05-05; verify with `sourcing.csv` before purchasing."
- "Tool inventory assumes Maker Nexus access; if building elsewhere, add ShopBot/lathe/Epilog rental costs."

## Image sourcing status

| Image | Status | Path |
|---|---|---|
| hero-finished-set.jpg | TBD | needs photoshoot after Phase 12 |
| body-cross-section.svg | partial | covered by `drawings/Am.svg` etc., needs section overlay |
| bird-block.png | TBD | render after Phase 10 |
| drone-block-set.png | TBD | render after Phase 9 |
| walnut-blank.jpg | placeholder | use Hardwoods to Get product photo |
| maple-blank.jpg | placeholder | use Bell Forest product photo |
| 1-16-upcut.jpg | placeholder | use IDC Woodcraft product photo |

## Output

Render the visual BOM as `images/visual-bom.png` at 11×17 (tabloid) at 300 dpi. Inline a copy in `print-packet.pdf` and `site/index.html`.
