// Drone Flute family — bore + tone-hole-schedule envelope master (DXF-first family).
//
// Authority: pending_measurement. NOT fabrication authority until reviewed
// (see visual-output-register.csv CAD-001 and cad/mcp-session-log.md).
// dxf-shop-authority.md still lists body/bore/tone-hole/drone-block DXF/CAD
// as "missing" — this .scad is the first parametric envelope, not a
// replacement for that reviewed export chain (DXF-REV-001, FAB-BORE-009
// remain blocked until a reviewed CAD/DXF revision is released).
//
// SCOPE / OUT OF SCOPE (Woodwind addendum, 2026-07-01):
//   In scope  — melody bore + drone-bore envelope diameters and lengths,
//               octagonal body facet envelope, and the six tone-hole
//               positions along the melody bore (equation-driven, like
//               fret slots).
//   Out of scope — duct/fipple geometry: SAC chamber, splitting-edge
//               (window) profile, bird-block/flue-gap voicing, undercutting
//               of tone holes, drone-socket tenon fit. These are exactly
//               the "hand-refined, tuning-sensitive" regions that must stay
//               hand-refined and are NOT modeled here. See dxf-shop-authority.md.
//
// Dimension sources (do not edit values without updating the source record):
//   - member_id / target_hz / bore_id_in / total_length_in / body_od_in /
//     facet_side_in / drone_bore_in: family-spec.csv (one row per member;
//     dimension_provenance = measurement_required for every row).
//   - governing acoustic model (open-open pipe + K2 bore correction) and
//     hole-position formula: design.md "Governing model" section, mirrored
//     in drone-flutes-starter.wl (source-only, not executed here).
//     f = c / (2*L_eff); L_eff = (c/(2*f0)) * (1 + K2(bore_id));
//     pos_from_foot = L_eff * (1 - f0/f_hole); pentatonic minor semitone
//     offsets [+3,+5,+7,+8,+10,+12] from the fundamental.
//   - facet geometry constants (facet_allowance, n_facets, wall thickness):
//     drone-flutes-starter.wl "Faceting" section, itself a mirror of
//     Drone-Flutes-Design.xlsx Master_Inputs — NOT independently re-derived
//     here, carried through as pending_measurement.
//   - tone-hole diameter per member: bom.csv row 3.5 ("Brad-point drills,
//     4 each, 1/4, 9/32, 5/16, 11/32 ... Tone holes"). ASSUMPTION: the four
//     bit sizes are read in ascending-bore order (Am->F#m->Em->Dm) since
//     bom.csv does not tag each size to a member; flag for review.
//   - melody-bore-to-drone-bore centerline offset: NOT present in
//     family-spec.csv, design.md, or the workbook mirror. TBD — exposed as
//     a top-level parameter (bore_offset_in) so it can be corrected in one
//     place once a reviewed value exists. Do NOT treat the placeholder as
//     fabrication authority.
//
// Units: inches.

/* [Family member] */
// 0=Am, 1=F#m, 2=Em, 3=Dm (family-spec.csv row order)
member = 0;

member_ids   = ["DRN-Am", "DRN-Fsm", "DRN-Em", "DRN-Dm"];
target_hz    = [440.000, 369.994, 329.628, 293.665];          // family-spec.csv target_hz
bore_id_in   = [0.750,   0.875,   1.000,   1.125];             // family-spec.csv bore_id_in
total_len_in = [21.967,  24.987,  27.225,  29.824];             // family-spec.csv total_length_in
body_od_in   = [1.300,   1.425,   1.550,   1.675];              // family-spec.csv body_od_in (round, pre-facet)
facet_side_in= [0.497,   0.549,   0.601,   0.652];              // family-spec.csv facet_side_in
drone_bore_in= [0.625,   0.750,   0.875,   1.000];              // family-spec.csv drone_bore_in

// bom.csv row 3.5 brad-point set, ascending-bore-order ASSUMPTION (ping for review).
tone_hole_dia_in = [0.250, 0.28125, 0.3125, 0.34375];

f0_hz          = target_hz[member];
bore_dia_in    = bore_id_in[member];
total_length_in= total_len_in[member];
body_dia_in    = body_od_in[member];
facet_side_len = facet_side_in[member];
drone_dia_in   = drone_bore_in[member];
hole_dia_in    = tone_hole_dia_in[member];

/* [Acoustic constants — design.md governing model] */
c_speed_of_sound_in_s = 13552; // in/s at 68 F, design.md
k_end                 = 0.6;   // open-end correction multiplier, design.md

/* [Faceting — drone-flutes-starter.wl mirror of workbook Master_Inputs] */
n_facets        = 8;     // octagon; workbook n_facets default
facet_allowance = 0.05;  // wl "Faceting" section
wall_in         = 0.25;  // wl per-member wall (same for all 4 members currently)

/* [Bore-to-bore offset — TBD, not in family-spec.csv or design.md] */
// ASSUMPTION placeholder only; do not fabricate from this value.
bore_offset_in = body_dia_in / 3;

/* [Pentatonic minor hole schedule — design.md] */
pentatonic_minor_semitones = [3, 5, 7, 8, 10, 12];

// ---------------------------------------------------------------------------
// Derived acoustic geometry (formulas, not baked values)
// ---------------------------------------------------------------------------

function k2_correction(bore_in) =
    bore_in <  0.750 ? -0.020 :
    bore_in <  0.875 ? -0.007 :
    bore_in <  1.000 ?  0.004 :
    bore_in <  1.125 ?  0.007 :
                         0.013;

function acoustic_length_in(f0, bore_in) =
    (c_speed_of_sound_in_s / (2 * f0)) * (1 + k2_correction(bore_in));

function hole_freq_hz(f0, semitone) = f0 * pow(2, semitone / 12);

function hole_pos_from_foot_in(f0, bore_in, semitone) =
    acoustic_length_in(f0, bore_in) * (1 - f0 / hole_freq_hz(f0, semitone));

// Regular-octagon circumradius from edge (facet) length.
function facet_circumradius_in(side_len) = side_len / (2 * sin(180 / n_facets));

// ---------------------------------------------------------------------------
// Modules
// ---------------------------------------------------------------------------

module melody_bore() {
  // Envelope only — no window/SAC/splitting-edge cut modeled (out of scope).
  rotate([0, 90, 0])
    cylinder(h = total_length_in, d = bore_dia_in, $fn = 64);
}

module drone_bore() {
  // Parallel envelope; length approximated at the shared body length since
  // the drone-block cavity length is a duct/voicing detail (out of scope).
  translate([0, bore_offset_in, 0])
    rotate([0, 90, 0])
      cylinder(h = total_length_in, d = drone_dia_in, $fn = 48);
}

module body_envelope_round() {
  // Pre-facet turned envelope, body_od_in from family-spec.csv.
  rotate([0, 90, 0])
    cylinder(h = total_length_in, d = body_dia_in, $fn = 96);
}

module body_envelope_facet() {
  // Reference-only octagon derived from facet_side_in; exact facet index/
  // rotation datum is a shop-jig concern (dxf-shop-authority.md
  // fixture-vblock-indexing.dxf), not modeled here.
  r = facet_circumradius_in(facet_side_len);
  rotate([0, 90, 0])
    cylinder(h = total_length_in, r = r, $fn = n_facets);
}

module tone_holes() {
  // Six pentatonic-minor holes, equation-driven positions from the foot
  // (x=0 = foot / open end). Radial placement on top of the bore only —
  // undercut/counterbore is out of scope (dxf-shop-authority.md).
  for (semitone = pentatonic_minor_semitones) {
    pos = hole_pos_from_foot_in(f0_hz, bore_dia_in, semitone);
    translate([pos, 0, bore_dia_in / 2])
      cylinder(h = wall_in * 3, d = hole_dia_in, center = true, $fn = 32);
  }
}

module drone_flute_assembly() {
  difference() {
    body_envelope_round();
    melody_bore();
    drone_bore();
    tone_holes();
  }
  // Faceted reference envelope shown as a translucent guide, offset above
  // the round body for comparison (not a cut/union — reference only).
  translate([0, 2 * body_dia_in, 0])
    body_envelope_facet();
}

drone_flute_assembly();

// Echo the hole schedule so `openscad` doubles as a position/frequency check.
echo(str("member=", member_ids[member], " f0_hz=", f0_hz,
         " L_acoustic_in=", acoustic_length_in(f0_hz, bore_dia_in)));
for (semitone = pentatonic_minor_semitones)
  echo(str("hole_semitone_", semitone,
           "_freq_hz=", hole_freq_hz(f0_hz, semitone),
           "_pos_from_foot_in=", hole_pos_from_foot_in(f0_hz, bore_dia_in, semitone)));
