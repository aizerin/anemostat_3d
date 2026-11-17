// Short samples cut from the production geometry in print orientation.
use <valve.scad>
$fn = 192; // Match the facet count of the full valve.
sample = "both"; // [both,body,insert]
height = 8; // Two thread pitches.
sample_clearance = 0.15; // Radial clearance in mm.
module body_sample() {
    intersection() {
        threaded_seat();
        translate([-60,-60,0]) cube([120,120,height]);
    }
}
module insert_sample() {
    // Use the entry end of the insert to retain its original thread lead-in.
    intersection() {
        translate([0,0,height-32]) insert(sample_clearance);
        translate([-60,-60,0]) cube([120,120,height+0.1]);
    }
}
if(sample=="body") body_sample();
else if(sample=="insert") insert_sample();
else {
    translate([-55,0,0]) body_sample();
    translate([55,0,0]) insert_sample();
}
