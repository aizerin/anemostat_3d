// Hand key for the DN125 insert. Print with the guide facing up.
// Z=0 faces the user. The insert face seats against the rim at grip height.
bore_diameter = 96;
radial_clearance = 0.35;
guide_depth = 6;
tooth_width = 7.4; // The mating notch is 8 mm wide.
tooth_height = 1.2; // The mating notch is 1.4 mm deep.
grip_height = 14;
grip_width = 12;
$fn = 192;
guide_radius = bore_diameter/2-radial_clearance;
rim_radius = bore_diameter/2+1.65;
inner_radius = guide_radius-2.8;
eps = 0.02;

module rim() {
    rotate_extrude() polygon([
        [inner_radius,0], [rim_radius-0.6,0], [rim_radius,0.6],
        [rim_radius,grip_height], [guide_radius,grip_height],
        [guide_radius,grip_height+guide_depth-1],
        [guide_radius-1,grip_height+guide_depth],
        [inner_radius,grip_height+guide_depth]]);
}
module crossbar() {
    // Round the edges of the finger grip.
    rotate([90,0,90]) linear_extrude(height=2*(inner_radius+1),center=true)
        offset(r=1) offset(delta=-1)
            square([grip_width,grip_height],center=true);
}
module key() {
    union() {
        rim();
        translate([0,0,grip_height/2]) crossbar();
        for(a=[0,180]) rotate(a) intersection() {
            translate([inner_radius,-tooth_width/2,grip_height-eps])
                cube([rim_radius-inner_radius,tooth_width,tooth_height+eps]);
            cylinder(r=rim_radius,h=grip_height+tooth_height);
        }
    }
}
key();
