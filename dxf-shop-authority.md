# DXF-First Shop Authority Checklist

Current status: DXF-first shop handoff checklist; acoustic fabrication authority
is not released.

Issue #1 asks this packet to move toward a validated shop handoff while keeping
decorative inlay assets separate from acoustic and fabrication authority. This
file names what exists and what must exist before a maker cuts acoustic
geometry.

## Current Authority Inventory

| Artifact | Current status | Authority boundary |
| --- | --- | --- |
| `Drone-Flutes-Design.xlsx` | parametric design source | Governs formulas and design intent, but does not replace exported/reviewed shop DXF/CAD. |
| `sw-reference/Drone-Flutes-SolidWorks-MasterLayout.docx` | SolidWorks setup reference | Reference for rebuilding CAD; not a checked-in CAD model or CAM export. |
| `drawings/*.svg` | preview drawings | Review previews only; not CNC, router, drill, lathe, or inspection authority. |
| `inlay-patterns/*/*.dxf` | decorative inlay artwork | Decorative pocket/plug geometry only after body facet datum is proven; not acoustic authority. |
| Body/bore/tone-hole DXF or CAD | missing | Required before acoustic body CNC routing. |
| Drone-block/socket DXF or CAD | missing | Required before batch machining swappable drone blocks. |
| Fixture/V-block DXF or CAD | missing | Required before repeatable facet indexing and inlay registration. |

## Required Shop-Authority Exports

Create or name the following before releasing this as a validated DXF-first
shop packet:

| Required export | Must control | Source trace |
| --- | --- | --- |
| `cad/DRN-*-body-bore.dxf` or equivalent CAD | split-body bore, SAC chamber, window/splitting edge, open-foot datum | `Drone-Flutes-Design.xlsx`, `family-spec.csv`, reviewed CAD model |
| `cad/DRN-*-toneholes.dxf` | six tone-hole centers, diameters, undercut/counterbore notes, foot datum chain | workbook hole formulas plus first-article tuning correction |
| `cad/DRN-*-drone-blocks.dxf` or turned-part drawing | unison, fifth-below, octave-below block cavity lengths and tenon fit | workbook/drone tuning table plus measured swap response |
| `cad/fixture-vblock-indexing.dxf` | V-block angle, stop datum, rotation/indexing features, clamp clearance | body OD/facet data plus shop workholding review |
| `cnc/README.md` or setup sheet | tool sequence, stock datum, cutter list, feeds/speeds source, go/no-go checks | reviewed CAD/DXF revision and shop profile |

## Go/No-Go Checks

- Go only when all acoustic and fit-critical DXF/CAD exports name the same
  workbook revision and member configuration.
- Go only after first-article flute data records fundamental, six melody notes,
  and all three drone-block modes in `validation.csv` or
  `shop-validation-gates.csv`.
- Go only after breath-response notes record onset, choking, air noise, and
  stable tone behavior for the SAC/window/bird setup.
- Go only after tenon/socket slip fit and facet-indexing checks pass on scrap
  or the first article.
- Stop if a decorative inlay DXF is being used to infer flute-body dimensions,
  hole locations, bore geometry, drone-block cavity length, or fixture datums.

## Decorative Inlay Boundary

The inlay DXFs are useful shop assets for aesthetic pockets and plugs, but they
are downstream of the acoustic body. Place them after the body datum, facet
width, and member length are confirmed from authority geometry. Do not let an
inlay pattern become the source of body length, facet size, tone-hole position,
or drone-block fit.
