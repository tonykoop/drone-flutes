# Risks — Drone Flute Set (F#m, Em, Dm, Am)

Structured risks for the four-flute build. Each risk follows the v4 red-team specialist format: Symptom → Mechanism → Test → Mitigation → Severity. Severity scale is Low (cosmetic), Medium (performance-affecting), High (safety or hard-failure).

This file is the red-team companion to the design workbook and build method. Run through it once before committing material; revisit after any drone-block or window-shape change.

---

## Acoustic

### Drone bore couples back into melody bore via the splitting edge

**Symptom:** When playing a melody hole, you hear the drone interfere — beating, intermodulation, or the drone going slightly flat/sharp depending on which melody hole is open.

**Mechanism:** The drone bore and melody bore share the same SAC (slow air chamber) feed. If the splitting edge geometry doesn't isolate the two flows, breath pressure spilling into the drone bore modulates the drone's effective length. The two bores aren't acoustically decoupled — they're side-by-side in the same body.

**Test:** Play each melody hole sustained for 5+ seconds while monitoring the drone with a chromatic tuner on a separate channel. If drone cents reading wanders by more than ±5 cents across melody fingerings, coupling is too strong.

**Mitigation:** Increase splitting-edge thickness in the SAC-to-drone-bore wall (`drone_isolation_wall` in `Master_Inputs`). Default is 0.125"; bump to 0.156" if coupling is heard. Alternatively, taper the drone bore inlet so its impedance is mismatched at the SAC junction.

**Severity:** Medium

### Drone block tenon humidity-fit drift

**Symptom:** In summer (high RH), drone block won't insert without forcing. In winter (low RH), drone block falls out under its own weight, drifting tuning sharp by 5–15 cents.

**Mechanism:** Walnut tenon expands radially with moisture; ID of body socket also expands but at a different rate (cross-grain vs long-grain, slightly different equilibrium moisture content). The fit goes from snug → tight → loose across an annual humidity cycle.

**Test:** Build one block in winter shop conditions (~30% RH); measure tenon OD. Place in sealed jar with saturated KCl solution (~85% RH equivalent) for 7 days. Re-measure. Diameter delta > 0.003" → expect seasonal fit issues.

**Mitigation:** Turn drone tenons in winter (when wood is at lower MC). Sand to fit just slightly snug. The fit will loosen in summer to comfortable, then return to snug in winter — the operating window centers on shop conditions.

**Severity:** Medium

### Hole 6 (octave) tunes sharp due to proximity to window

**Symptom:** Octave tone hole reads consistently sharp by 8–20 cents across all four flutes; flatter holes (1–5) tune correctly.

**Mechanism:** Hole 6 sits closest to the window. End correction at the window end of the bore is steeper than a free open-end because of the splitting-edge geometry. The standard `pos_from_foot = L_eff · (1 − f₀/f_hole)` formula assumes a uniform open-end correction, which underestimates the effective length toward the window.

**Test:** After tuning holes 1–5 to within ±3 cents, measure hole 6. If consistently >5 cents sharp, the model is undershooting.

**Mitigation:** Add a `hole_6_window_correction` global (in semitones) to `Master_Inputs`; subtract it from hole 6's offset in `Hole_Schedule` so the formula moves the hole slightly toward the foot. Calibrate empirically across the four-flute set; record the correction in the per-family corrections database via `record_measurement.py`.

**Severity:** Medium

---

## Structural

### Bore mismatch at glue-up — split body halves drift on the datum pins

**Symptom:** After Phase 3 glue-up and Phase 4 lathe rounding, the bore profile has a visible step where the two halves meet. Air leaks at the joint; tone is breathy across all notes.

**Mechanism:** Datum holes drilled in Phase 1 are 3/16" but the dowels used for alignment are slightly undersize. Clamp pressure during glue-up shifts halves by 0.005–0.020".

**Test:** After dry-fit, look at the bore from each end with a flashlight. Step or offset visible at the parting line is a fail.

**Mitigation:** Use 3/16" *wood* dowels (slightly oversize after a steam soak), not metal pins. Insert dry, then soak briefly so they swell into the holes. Per build-method Phase 3, this is already in the build doc — verify on first prototype before committing the rest.

**Severity:** High (a leaky bore makes the flute unsellable; have to reject the body and start over)

### Splitting edge too thin — collapses under play

**Symptom:** After 10–50 hours of play, splitting edge splinters or compresses. Breathy tone develops; replacement requires new body.

**Mechanism:** The splitting edge is the thinnest feature in the flute. In Phase 7 it gets cut with a 1/16" upcut spiral; over-engagement leaves the wall too thin (<0.020"). Repeated breath pressure cycling fatigues the wall.

**Test:** Measure splitting-edge wall thickness with feeler gauges or a thin caliper before Phase 11 finish. Below 0.020" is a fail.

**Mitigation:** During Phase 7, leave 0.005" skin on the splitting edge during CNC. Finish with a small chisel and 320-grit sandpaper. Per the existing build method; verify with caliper before finishing.

**Severity:** High

### Inlay plug pops out under finish-cure stress

**Symptom:** Plug separates from pocket after first or second coat of Tru-Oil. Wood movement during finish soak overcomes the 0.002" interference fit.

**Mechanism:** Maple plug and walnut body have different equilibrium moisture content under finish. Finish penetrates and triggers a small moisture exchange; the differential expansion exceeds the fit tolerance briefly.

**Test:** After Phase 8 inlay set, leave the body for 7 days at shop humidity. Tap each plug with a fingernail — plug should ring solid, not click loose. Any click = re-glue with thicker CA.

**Mitigation:** Use thin CA glue (Starbond) for the initial set; backfill with thicker CA into any gap. Apply finish only after the 7-day humidity-equilibration window.

**Severity:** Medium (re-glue is cheap but slows shipping)

---

## Ergonomic

### Hole spacing on Dm exceeds comfortable hand reach

**Symptom:** Dm flute is the longest in the set (~30"). Holes 1 and 6 may span more than the ~9" comfortable reach for a 5th-percentile player's grip with the standard six-hole layout.

**Mechanism:** Hole-position formula scales with bore length. Holes are at fixed *fractions* of `L_acoustic_corrected`. As `L` grows for low-pitched flutes, absolute hole spacing grows proportionally. For Dm at 29.8" with hole 1 at ~0.75 · L and hole 6 at ~0.4 · L, span between hole 1 and hole 6 is ~10.4".

**Test:** Measure span from hole 1 to hole 6 on the Dm prototype. If >9", check hand-reach compatibility against intended player.

**Mitigation:** For Dm, allow split-hand fingering (3 holes per hand). Document this in the assembly manual / README so a player isn't surprised. Alternative: offset hole 6 slightly toward foot (sacrificing some intonation accuracy for ergonomic playability) — only if reach is a hard constraint.

**Severity:** Low (only affects players with smaller hands; documentation mitigates)

### Drone-block-to-body angle awkward in standing play

**Symptom:** Drone block protrudes at 90° from the body axis. In standing play with strap, the drone block's weight pulls the body off-axis and rotates it in the player's hands.

**Mechanism:** The drone bore is parallel to the melody bore but on the opposite side of the body. Drone block + tenon adds ~3" of mass at one side of the body; the moment arm exceeds neutral grip.

**Test:** Hold finished flute in standing playing position with strap. If body rotates noticeably or strap shifts, ergonomic mass balance is off.

**Mitigation:** Add a small counterweight or strap routing to the opposite side of the body; or design drone block with a hollow tenon (lower mass) for the longer flutes. Document in the assembly manual.

**Severity:** Low

---

## Supply

### Walnut color match across the four-flute set

**Symptom:** Four flutes look like four different woods — light blonde walnut next to dark chocolate. The set looks unfinished or hastily-built.

**Mechanism:** Walnut color varies dramatically by source, board, and time-since-cut. Heartwood vs sapwood contrast; faded vs unfaded boards.

**Test:** Lay out all four blanks side-by-side in shop daylight before stock prep. If color delta is jarring, source is too varied.

**Mitigation:** Order all four blanks from the same supplier on the same day, ideally from adjacent boards. Specify "matched set" when ordering. Tony's typical supplier pairs walnut for matched purpose at no premium when asked.

**Severity:** Low (cosmetic; only affects gallery aesthetic, not function)

### Hard maple inlay stock thickness drift

**Symptom:** 1/16" plugs are 0.062" — but supplied stock varies 0.058–0.068" across a single board. Plug fits one pocket loosely and the next too tightly.

**Mechanism:** Drum sander inconsistency at the supplier. Big-box hardware-store maple varies more than specialty luthier stock.

**Test:** Measure supplied stock at 5 locations across the board with calipers before machining. If range > 0.005", the stock isn't suitable for plug work.

**Mitigation:** Drum-sand the stock yourself in Phase 1 (before Phase 8 inlay) to a measured 0.0625" ±0.001". Or order from a specialty supplier (e.g., Gilmer Wood) where dimensional tolerance is tighter.

**Severity:** Medium (loose plugs need re-glue; tight plugs need re-machining)

---

## Fit/Finish

### Tru-Oil pooling in inlay grooves

**Symptom:** Finish accumulates in the chevron grooves of the inlay pattern, leaving a glossy raised "pool" around each engraved line. Visually muddy; loses the geometric crispness.

**Mechanism:** Tru-Oil is a thin oil-varnish blend. Capillary action pulls it into engraved grooves; as solvents evaporate, oil + resin remain at the bottom, building up over coats.

**Test:** After coat 2, examine inlay under raking light. Visible darker bands inside the grooves = pooling.

**Mitigation:** Wipe excess Tru-Oil from inlay grooves with a foam swab between coats. Or apply finish first, sand back the inlay area, *then* glue inlay flush — but this changes the build order.

**Severity:** Low (cosmetic; affects gallery photography but not play)

### CA glue squeeze-out around inlay margins

**Symptom:** White haze of cured CA glue at the perimeter of each inlay plug. Visible against walnut body.

**Mechanism:** Thin CA glue wicks out of the joint when the plug is pressed in. Spread is fast (seconds) and the haze is hard to remove without affecting the surrounding finish.

**Test:** After Phase 8 plug set, examine plug margin with a 5× loupe. Any white residue = squeeze-out.

**Mitigation:** Apply masking tape around the pocket margin before pressing the plug; remove tape and any squeeze-out within 30 seconds. Sand finish-flush in Phase 8 final step rather than just plug-flush.

**Severity:** Low

---

## Recap

| Severity | Count | Top concern |
|---|---|---|
| **High** | 2 | Bore mismatch at glue-up (use wood dowels, not pins) |
| **Medium** | 5 | Hole 6 sharps from window proximity (add empirical correction global) |
| **Low** | 5 | Tru-Oil pooling, CA squeeze-out, hand-reach on Dm |

Run the High-severity tests before committing to all four bodies. A failed Phase 3 glue-up is a 4-week setback; verify on the first prototype.
