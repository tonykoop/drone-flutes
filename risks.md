# Risks — Drone Flute Family (red-team output)

Structured failure-mode walk per v4 red-team specialist. Every risk has a verification test attached.

## Acoustic risks

### A-1 — Hole 6 (octave) consistently sharp
**Likelihood:** medium · **Severity:** medium
**Mode:** Hole 6 sits closest to the window; small position errors are amplified by the formula.
**Cause:** K2 correction at the high-frequency end may underpredict the foot-end correction's effect on the highest hole.
**Test:** After Phase 6 tuning, measure octave hole frequency on each flute; if it's > +5 cents on more than 2 of 4 flutes, capture a per-flute correction in the Excel K2 table for the next family.

### A-2 — Drone chamber leaks into melody bore
**Likelihood:** low · **Severity:** high
**Mode:** Glue-up of the split-body must perfectly seal between the two parallel chambers. A pinhole leak between melody and drone bores ruins both notes.
**Cause:** Bandsaw resaw ridges + insufficient hand-planing + glue starvation in the long bore region.
**Test:** Pre-glue, run a fingertip along the inside of each bore in both halves to confirm no ridges. Post-glue (after cure) blow into the melody side with the drone block out; should hear ONLY melody fundamental, no drone artifact.

### A-3 — Splitting edge too thick = breathy tone
**Likelihood:** medium · **Severity:** medium
**Mode:** The 1/16" upcut is leaving 0.005" skin to be finished by chisel; if Tony skips the chisel step the edge stays too thick and the flute sounds breathy.
**Cause:** Time pressure during build, or unclear documentation.
**Test:** Listen-test after Phase 7 — clean tone within 3 puffs = pass. Otherwise sharpen with chisel.

### A-4 — Cross-flute pitch drift from environmental conditions
**Likelihood:** high · **Severity:** low
**Mode:** Tony's shop temperature varies 60–75°F seasonally. Speed of sound changes ~5 cents per 10°F.
**Cause:** Physics; not avoidable.
**Test:** Tune all four flutes in a single session at a known shop temp. Record temperature in `validation.csv`. Differences across builds will be expected.

## Structural risks

### S-1 — Walnut split along glue line
**Likelihood:** low · **Severity:** high
**Mode:** Long glue line (up to 30") in walnut + humidity swing → split.
**Cause:** Insufficient acclimation, marginal glue coat, or seasonal humidity change after delivery.
**Test:** Before glue-up, both halves must be from the same blank with the same MC. Use Type II glue (water-resistant) and 6+ clamps. Post-build, store flute in 40–50% RH.

### S-2 — Drone tenon snaps
**Likelihood:** low · **Severity:** medium
**Mode:** 0.75" tenon in walnut at small diameter (0.625" for Am) → bending stress if drone block dropped.
**Cause:** End-grain runout in the drone block stock.
**Test:** Inspect tenon grain orientation — must be parallel to long axis. Drop test: drone block falls 24" onto carpet without tenon failure.

### S-3 — Octagonal facet too thin at peak
**Likelihood:** low · **Severity:** medium
**Mode:** After faceting, the wall thickness at the bore is `wall - facet_allowance/2`. At wall = 0.25" and allowance = 0.05", that's 0.225" — fine for walnut. But if Tony reduces wall to 0.20" thinking he's saving weight, walls drop to 0.175" and crack risk rises.
**Cause:** Future wall-thickness reduction without recomputing.
**Test:** After CNC faceting, verify wall thickness at bore with calipers. Must be ≥ 0.20" structural minimum.

## Ergonomic risks

### E-1 — Hole 1 (m3) reach for small hands
**Likelihood:** medium · **Severity:** low
**Mode:** Em and Dm flutes are 27–30 in long; the m3 hole is 3.3–3.7 in from foot. A 5th-percentile hand may struggle to reach hole 1 while keeping the bird block under the upper lip.
**Cause:** Family scaling unconstrained by anthropometric data.
**Test:** 5th-percentile fingerspan = ~7" hand length. Verify that hole 1 to hole 6 span is < 6" for Em and Dm. If not, consider adjusting scale offsets or adding a key-extension lever (out of scope for v1 of this family).

### E-2 — Window position obscured by player's lip
**Likelihood:** low · **Severity:** low
**Mode:** Player's lower lip rests on top of bird block; if `bird_height` is too low, lip blocks window airflow.
**Cause:** Standard NAF design; well-understood. Default 0.75" bird height clears.
**Test:** Slow puff while resting normally; tone responds without lip-curling effort.

## Supply risks

### Su-1 — Hard maple 1/16" thin stock backorder
**Likelihood:** medium · **Severity:** low
**Mode:** Bell Forest occasionally runs out of 1/16" inventory.
**Cause:** Niche thickness for thin-stock work.
**Test:** Verify in-stock at order time. If unavailable, resaw 1/8" stock to 1/16" — adds 1 hour but not blocking. Acceptable substitute: holly, beech.

### Su-2 — Walnut grade variability
**Likelihood:** medium · **Severity:** medium
**Mode:** Black walnut varies in figure, color (sapwood vs heartwood), and density. A bargain blank may have visible sapwood streaks that crash the aesthetic.
**Cause:** Natural material variation; not all suppliers grade tightly.
**Test:** Order from Hardwoods to Get with explicit "no visible sapwood" specification, or pick personally if local. Reject and re-source if delivery has > 10% sapwood by area.

## Fit / finish risks

### F-1 — Inlay plug flush-sand removes too much
**Likelihood:** medium · **Severity:** low
**Mode:** Sanding inlay flush also removes a thin layer of the surrounding walnut, lowering the body OD locally.
**Cause:** Aggressive grit + flat block + over-confident builder.
**Test:** Pre-inlay caliper measurement of body OD at each band location. Post-flush-sand re-measure. Loss should be < 0.005". If more, drop to 320 grit on a smaller block.

### F-2 — Tru-Oil yellowing on maple inlay
**Likelihood:** low · **Severity:** low
**Mode:** Tru-Oil ambers slightly over time; on bright maple this is visible; some clients perceive it as discoloration.
**Cause:** Tru-Oil is a tung/varnish blend; ambering is normal.
**Test:** Document the look at delivery. Provide care notes that some warming over 1–2 years is normal and is shared by other oil finishes (Watco, Howard's). Alternative: shellac sealcoat under Tru-Oil reduces ambering on light woods.

### F-3 — Drone block tenon over-clearance with humidity
**Likelihood:** medium · **Severity:** low
**Mode:** Tenon turned at 60% RH; in low-humidity winter (20% RH) walnut shrinks, tenon becomes loose, drone falls out mid-play.
**Cause:** Wood movement; not avoidable but bounded.
**Test:** Turn tenons in low-humidity season. Aim for 0.005" clearance at 30% RH; will tighten in summer, still slip-fit.

## Verification gates (must pass before shipping)

- [ ] All flutes tuned within ±5 cents on every hole, recorded in `validation.csv`.
- [ ] Drone chamber tested as independent (no melody/drone leak — A-2 test).
- [ ] Wall thickness verified ≥ 0.20" at bore on every facet (S-3 test).
- [ ] Drop test on drone tenon (S-2 test).
- [ ] Visual inlay flush within 0.005" (F-1 test).
- [ ] Glue line inspected on each body, no visible gap (S-1 test).
- [ ] Photographs and audio recordings archived to `data/` and `images/`.
