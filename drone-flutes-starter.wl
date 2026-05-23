(* ::Package:: *)

(* ::Section:: *)
(* Drone Flute Family — Wolfram Parametric Notebook *)
(* Mirror of Drone-Flutes-Design.xlsx Master_Inputs sheet *)
(* Variable names match the Excel + SolidWorks globals *)

(* ::Subsection:: *)
(* Acoustic constants *)

cSpeedOfSound = 13552;        (* in/s at 68 F *)
A4Reference   = 440;          (* Hz, concert pitch *)
endK          = 0.6;          (* open-end correction multiplier *)

(* ::Subsection:: *)
(* SAC + bird geometry *)

SACLength    = 5.5;
SACWall      = 0.25;
flueGap      = 0.040;
birdLength   = 2.0;
windowLength = 0.625;

(* ::Subsection:: *)
(* Drone block *)

droneOffsetSt    = 0;        (* 0=unison, -7=fifth, -12=octave *)
droneBlockLength = 3.5;

(* ::Subsection:: *)
(* Faceting *)

nFacets       = 8;
facetChord    = Tan[Pi/nFacets];
facetInset    = 0.10;
facetAllowance= 0.05;

(* ::Subsection:: *)
(* K2 piecewise correction by bore ID *)

K2[bore_] := Piecewise[{
  {-0.020, bore < 0.75},
  {-0.007, 0.75 <= bore < 0.875},
  { 0.004, 0.875 <= bore < 1.0},
  { 0.007, 1.0 <= bore < 1.125},
  { 0.013, bore >= 1.125}
}];

(* ::Subsection:: *)
(* Per-key inputs *)

members = <|
  "Am"  -> <| "midi" -> 69, "boreID" -> 0.750, "wall" -> 0.25, "droneBoreID" -> 0.625 |>,
  "F#m" -> <| "midi" -> 66, "boreID" -> 0.875, "wall" -> 0.25, "droneBoreID" -> 0.750 |>,
  "Em"  -> <| "midi" -> 64, "boreID" -> 1.000, "wall" -> 0.25, "droneBoreID" -> 0.875 |>,
  "Dm"  -> <| "midi" -> 62, "boreID" -> 1.125, "wall" -> 0.25, "droneBoreID" -> 1.000 |>
|>;

(* ::Subsection:: *)
(* Derived dimensions *)

fundamentalFreq[midi_] := A4Reference * 2^((midi - 69)/12);

acousticLength[midi_, bore_] := cSpeedOfSound / (2 * fundamentalFreq[midi]) * (1 + K2[bore]);

borePhysical[midi_, bore_] := acousticLength[midi, bore] - 2 * endK * (bore/2);

bodyODRound[bore_, wall_] := bore + 2*wall + facetAllowance;

bodyODFlat[bore_, wall_] := bodyODRound[bore, wall] - 2*facetAllowance;

facetSide[bore_, wall_] := bodyODFlat[bore, wall] * facetChord;

totalLength[midi_, bore_, wall_] := borePhysical[midi, bore] + SACLength + SACWall + birdLength - windowLength;

(* Pentatonic minor offsets and hole positions from foot *)
pentMinor = {3, 5, 7, 8, 10, 12};
holeFreq[midi_, semitone_] := fundamentalFreq[midi] * 2^(semitone/12);
holePosFromFoot[midi_, bore_, semitone_] := acousticLength[midi, bore] * (1 - fundamentalFreq[midi]/holeFreq[midi, semitone]);

(* ::Subsection:: *)
(* Build the family table *)

familyTable = Table[
  Module[{m = members[k], midi, bore, wall},
    midi = m["midi"]; bore = m["boreID"]; wall = m["wall"];
    {
      k,
      midi,
      N[fundamentalFreq[midi], 5],
      bore,
      N[acousticLength[midi, bore], 5],
      N[borePhysical[midi, bore], 5],
      N[bodyODFlat[bore, wall], 5],
      N[facetSide[bore, wall], 5],
      N[totalLength[midi, bore, wall], 5]
    }
  ],
  {k, {"Am", "F#m", "Em", "Dm"}}
];

Print[Grid[Prepend[familyTable,
  {"Key","MIDI","f0 (Hz)","bore_ID","L_acoustic","L_bore_phys","OD_flat","facet_side","L_total"}],
  Frame -> All]];

(* ::Subsection:: *)
(* Hole schedule for one selected key — change "selectedKey" to switch *)

selectedKey = "Am";
selectedMidi = members[selectedKey]["midi"];
selectedBore = members[selectedKey]["boreID"];

holeSchedule = Table[
  {
    {"H1 (m3)","H2 (P4)","H3 (P5)","H4 (m6)","H5 (m7)","H6 (oct)"}[[i]],
    pentMinor[[i]],
    N[holeFreq[selectedMidi, pentMinor[[i]]], 5],
    N[holePosFromFoot[selectedMidi, selectedBore, pentMinor[[i]]], 5]
  },
  {i, 1, Length[pentMinor]}
];

Print[selectedKey <> " hole schedule (positions from FOOT in inches):"];
Print[Grid[Prepend[holeSchedule, {"Hole","semitone offset","Hz","pos from foot (in)"}], Frame -> All]];

(* ::Subsection:: *)
(* Interactive Manipulate panel — sweep key + drone offset *)

Manipulate[
  Module[{midi, bore, wall, family, holes, freq},
    family = familyTable;
    midi = members[selectedKeyDyn]["midi"];
    bore = members[selectedKeyDyn]["boreID"];
    wall = members[selectedKeyDyn]["wall"];
    freq = fundamentalFreq[midi] * 2^(droneOffsetStDyn/12);
    holes = Table[{i, holeFreq[midi, pentMinor[[i]]]}, {i, 1, Length[pentMinor]}];
    Column[{
      Style["Member: " <> selectedKeyDyn, 16, Bold],
      "Fundamental frequency: " <> ToString[N[fundamentalFreq[midi], 5]] <> " Hz",
      "Drone frequency: " <> ToString[N[freq, 5]] <> " Hz",
      "Total length: " <> ToString[N[totalLength[midi, bore, wall], 5]] <> " in",
      "Hole frequencies: " <> ToString[N[holes[[All, 2]], 5]]
    }]
  ],
  {{selectedKeyDyn, "F#m", "key"}, {"Am","F#m","Em","Dm"}},
  {{droneOffsetStDyn, 0, "drone offset (semitones)"}, {0 -> "unison", -7 -> "5th below", -12 -> "octave"}}
];

(* ::Subsection:: *)
(* Audio synthesis — additive synthesis of one flute's pentatonic scale *)

synthFlute[midi_, durationSec_:0.5] := Module[{f0, scale},
  f0 = fundamentalFreq[midi];
  scale = Prepend[holeFreq[midi, #] & /@ pentMinor, f0];
  Sound[
    SoundNote[Round[12*Log2[#/440] + 69], durationSec, "Flute"] & /@ scale
  ]
];

(* Uncomment the next line to play the F#m flute scale *)
(* synthFlute[66] *)

(* ::Subsection:: *)
(* Validation harness *)

validate[] := Module[{checks},
  checks = {
    {"A4 = 440 Hz",          fundamentalFreq[69] == 440},
    {"F#4 ≈ 369.99 Hz",      Abs[fundamentalFreq[66] - 369.994] < 0.01},
    {"Am octave hole = 880", Abs[holeFreq[69, 12] - 880] < 0.5},
    {"Am chamber:bore in 17-21", 17 < acousticLength[69, 0.75]/0.75 < 21}
  };
  Grid[Prepend[checks, {"check","passes?"}], Frame -> All]
];

Print[validate[]];
