# Assembly Manual — Drone Flute Family

This manual is the shop-floor cheat sheet. For full context see `Drone-Flutes-BOM-Build-Method.docx`. For dimensional inputs see `Drone-Flutes-Design.xlsx`.

## Tools required

- ShopBot CNC router (Maker Nexus)
- Wood lathe (12 in swing minimum)
- Bandsaw (resaw the body blank)
- Drill press
- Epilog laser cutter (bird block engraving)
- Hand: chisels (1/4, 1/8), files (chainsaw + needle), calipers, square, marking gauge

## Safety

- Hearing protection during all power-tool ops.
- Dust mask (at minimum N95) when CNC routing walnut.
- Eye protection through entire build.
- Walnut dust is a known sensitizer; some people develop reactions over time. Run dust collection.

## Phase 1 — Stock prep

- [ ] Mill 4 walnut blanks to S4S per `cut-list.csv` (Am, F#m, Em, Dm).
- [ ] Verify grain runout ≤ 1:12 along the long axis. Reject and re-source if worse.
- [ ] Mark center reference line on each blank with marking gauge.
- [ ] Drill three 3/16" datum holes per blank (1" from each end + middle).
- [ ] **Acclimate 7 days minimum** before next phase.

## Phase 2 — Split-body CNC (bore + SAC)

- [ ] Bandsaw each blank exactly down centerline. Save kerf, hand-plane to glue surface.
- [ ] Match-mark each pair (left half / right half) with the key letter.
- [ ] Mount one half on CNC spoilboard with 3/16 dowels in datum holes + vacuum.
- [ ] Run **bore-profile pass** with 1/4 downcut spiral (cnc/{key}-bore.gcode). 18,000 rpm, 80 ipm, 0.25" per pass, 2 passes.
- [ ] Run **SAC pocket** pass with same bit (cnc/{key}-sac.gcode).
- [ ] Run **splitting-edge pass** with 1/16 upcut (cnc/{key}-window.gcode). Climb cut, single pass at 0.06" depth. Leave 0.005" skin — finish with chisel later.
- [ ] Flip second half onto same fixture, run mirrored G-code.
- [ ] Repeat for all 4 keys (8 halves total).

## Phase 3 — Glue-up

- [ ] Dry-fit each pair. If bore halves don't meet cleanly, lap mating faces on granite plate.
- [ ] Apply Titebond II thin and even to both faces.
- [ ] Clamp with 6+ clamps along the length, alternating top/bottom. Wax-paper between clamps and body.
- [ ] Use 3/16 dowels in datum holes during glue-up to hold alignment.
- [ ] Wait 24 h before unclamping.
- [ ] Inspect glue line. Repair gaps with thin CA + accelerator.

## Phase 4 — Lathe rounding

- [ ] Mount glued blank between centers (drive on foot, live on SAC end).
- [ ] Rough-turn round at ~800 rpm with 3/4 roughing gouge.
- [ ] Final-turn to **`body_OD_round`** from Design_Table for the active key. Leave 0.05" facet allowance.
- [ ] Sand on lathe to 220 grit while concentric.
- [ ] Pencil-mark a long reference line — this is the seam datum for faceting.

## Phase 5 — CNC faceting

- [ ] Build V-block jig: two MDF pieces at 22.5°, end-stops to lock axial position.
- [ ] Load 1/2 downcut spiral, 16,000 rpm, 120 ipm, 0.08" depth.
- [ ] Run pass 1: top facet. Verify with calipers (`body_OD_flat` from Excel).
- [ ] Rotate 45°, index using foot pin.
- [ ] Repeat 7 more times until all 8 facets are flat.

## Phase 6 — Tone hole drilling

- [ ] Mount body in horizontal jig with top facet up.
- [ ] Mark hole centers from `Hole_Schedule!{key}` sheet, measured from FOOT.
- [ ] Drill each hole through, with backer dowel inside bore to prevent blowout.
- [ ] Hole diameters per `Hole_Schedule!{key}_diameter`.
- [ ] Sand interior of each hole with rolled 320 grit.
- [ ] **Tune step:** play each note vs chromatic tuner, file foot-side edge to lower or fill bird-side edge with thin CA to raise.
- [ ] Once tuned, undercut the inside top edge of each hole at ~30° — this is the NAF "voice" undercut.

## Phase 7 — Window + splitting edge

- [ ] Plunge starting hole at splitting-edge location with 1/16 upcut.
- [ ] Cut window perimeter per `window_length × window_width` sketch.
- [ ] Shape the splitting edge with chisel + 320 grit. Edge should be knife-sharp.
- [ ] Test with light puff into SAC end. Clean tone? If breathy, sharpen edge. If too thin, glue veneer shim.

## Phase 8 — CNC inlay

- [ ] Place body back on V-block jig per facet.
- [ ] Load 1/16 upcut, 18,000 rpm, 60 ipm feed, 20 ipm plunge.
- [ ] Run **band1**, **band2**, **band3** pocket files for current facet (cnc/{key}-band[1-3]-pocket.gcode). 0.060" deep.
- [ ] Switch to maple stock fixture, run matching plug profile cuts at +0.001" oversize.
- [ ] Test fit. Sand plug underside if binding; thicker CA if loose.
- [ ] Apply thin CA, press plug into pocket, hit with accelerator.
- [ ] Repeat all 8 facets × 3 bands per flute = 24 inlay operations per flute, 96 total.
- [ ] **Feature panel:** pocket + plug pair on one chosen facet between band 2 and band 3, depth 0.080".
- [ ] Surface-sand body flat with 220 on flat block. Plugs sit flush.

## Phase 9 — Drone block set (3 per flute)

- [ ] Cut 12 walnut block blanks per `cut-list.csv` DRONE-x12.
- [ ] On lathe, turn each to body_OD with tenon at one end (tenon Ø = bore_ID − 0.005, length 0.75").
- [ ] Long-drill the drone bore from the foot end. Depth and diameter per Design_Table for that key + drone-offset combo:
  - Unison block: drone bore matches melody fundamental.
  - Fifth block: drone bore for fundamental × 2^(-7/12).
  - Octave block: drone bore for fundamental × 0.5 (longest cavity).
- [ ] Sand each block 320 grit.
- [ ] Engrave foot of each block on laser: U / 5 / 8.

## Phase 10 — Bird block (totem)

- [ ] Cut 4 walnut bird blanks (1×0.75×2 in).
- [ ] Laser-engrave the totem motif on each (eagle/wolf/bear/geometric — pick per flute personality).
- [ ] Cut shoulder on bottom matching top facet of body.
- [ ] Position over window. Verify flue gap 0.030–0.050".
- [ ] Sand bottom for tighter gap; veneer shim if too wide.

## Phase 11 — Finish

- [ ] Final sand body, drone blocks, bird blocks: 220 → 320 → 400 → 600.
- [ ] Wipe with tack cloth.
- [ ] Tru-Oil first coat (thin), 4–6 h dry.
- [ ] 600-grit sand between coats.
- [ ] 4–6 coats total.
- [ ] **Wait 7 days for full cure.**
- [ ] Buff with carnauba wax.

## Phase 12 — Final tuning + QA

- [ ] Tie bird block on with leather lacing.
- [ ] Insert unison drone block.
- [ ] Play pentatonic minor scale, tune each note with chromatic tuner. Record cents error in `validation.csv`.
- [ ] Swap to fifth, then octave drone blocks. Verify drone pitches.
- [ ] If any note > 5 cents off, adjust per Phase 6 tune step.
- [ ] Record video of all 4 flutes. Archive to `data/`.
- [ ] Photograph each finished flute against neutral background. Save to `images/`.

## Maintenance

- Reapply carnauba wax every few months.
- Avoid leaving in direct sun or near forced-air vents — humidity swings crack walnut.
- If a hole's tuning drifts, light file rather than CA fill (reversible).
