// Z=0 is the visible flange face. Positive Z points into the duct.
part="cross_section"; // [cross_section,assembly,body,insert,cover_plate,magnet_holder]
extension=6; // [0:0.5:12]
thread_pitch=4;
insert_clearance=0.15; // Target radial clearance in the original body (mm).
/* [Body] */
duct_diameter = 125;
neck_diameter = 115; // Measured outer diameter, independent of nominal duct size.
flange_overhang = 30; // Radial overhang beyond the outer neck wall.
flange_thickness = 2;
insertion_depth = 35; // Neck length measured from the back of the flange.
wall_thickness = 3.9; // A 2.5 mm groove leaves 1.4 mm of wall.
neck_chamfer = 1.2;
mounting_holes = true;
mounting_hole_diameter = 4.5;
mounting_hole_radius = 70;
/* [Seal groove] */
seal_width = 13;
groove_depth = 2.5;
groove_width_clearance = 0.4;
groove_end_offset = 8; // Distance from the end of the neck to the end of the groove ramp.
groove_ramp_angle = 55; // Ramp angle measured from horizontal.
/* [Magnets and mounting lugs] */
magnet_diameter = 6;
magnet_thickness = 3;
pocket_diameter_allowance = -0.10; // A 5.90 mm pocket gives 0.10 mm diametral interference for a 6 mm magnet.
pocket_chamfer = 0.3; // Chamfer the entrance to guide the magnet into the press fit.
pocket_depth_allowance = 0.4; // Additional pocket depth.
magnet_radius = 58; // The short foot extends from the magnet toward the mounting screw.
post_diameter = 11; // Diameter of the tall magnet post.
screw_step_height = 5; // Low step for the screw lug.
screw_lug_diameter = 10;
post_foot_diameter = 13; // Diameter at the foot of the 11 mm post.
post_taper_height = 2; // Transition from the foot to the narrower post.
holder_height = 13; // Magnet seating plane. The locating lip extends another 1.2 mm.
pin_radius = 63; // Pin position in the foot and flange.
pin_diameter = 2.5;
pin_projection = 1.8;
pin_spacing = 6;
pin_clearance = 0.3; // Diametral clearance for assembly and adhesive.
pin_chamfer = 0.35;
pin_bond_depth = 3.5; // Insert the flat end of the separate pin into the holder.
pin_roof_angle = 60; // Conical socket roof for support-free printing.
/* [Concealed locating lip] */
locating_lip_height = 1.2;
locating_clearance = 0.4; // Clearance per side, 0.8 mm across the diameter.
locating_lip_chamfer = 0.2;
/* [Cover plate] */
bed_margin = 1; // Margin on each side of the centered cover (mm).
bed_width = 248; // CORE One INDX
bed_depth = 205;
cover_thickness = 2;
magnet_boss_diameter = 8.6;
magnet_boss_height = 2; // Local reinforcement above the 2 mm plate.
/* [Print] */
facets = 192; // [96,160,192,256]
/* [Hidden] */
$fn = facets;
eps = 0.02;
OD = neck_diameter;
flange_diameter = OD+2*flange_overhang;
body_depth = flange_thickness+insertion_depth;
diameter_clearance = duct_diameter-OD;
ID = OD-2*wall_thickness;
R = ID/2;
neck_end_z = flange_thickness+insertion_depth;
groove_width = seal_width+groove_width_clearance;
groove_ramp_height = groove_depth*tan(groove_ramp_angle);
groove_z = neck_end_z-groove_end_offset-groove_width-groove_ramp_height;
lug_spacing = mounting_hole_radius-magnet_radius;
pin_offset = pin_radius-magnet_radius;
lug_diameter = screw_lug_diameter;
pin_hole_diameter = pin_diameter+pin_clearance;
roof_start_z = pin_bond_depth-pin_clearance/2*tan(pin_roof_angle);
pin_roof_height = pin_hole_diameter/2*tan(pin_roof_angle);
pin_length = pin_bond_depth+pin_projection;
cover_diameter = min(bed_width,bed_depth)-2*bed_margin;
cover_height = cover_thickness+magnet_boss_height;
// The cover bosses sit on the magnet faces inside the locating lips.
cover_z = -holder_height-magnet_boss_height-cover_thickness;
locating_recess_diameter = magnet_boss_diameter+2*locating_clearance;
locating_lip_diameter = max(post_diameter,locating_recess_diameter+2); // Keep at least 1 mm of wall.
lip_taper_height = max(eps,(locating_lip_diameter-post_diameter)/2);
assert(OD>0 && ID>0 && diameter_clearance>=0);
assert(flange_thickness>=2 && flange_diameter>OD);
assert(wall_thickness-groove_depth>=1.2);
assert(body_depth>flange_thickness+10);
assert(groove_z>flange_thickness+1);
assert(groove_end_offset>neck_chamfer);
assert(groove_ramp_angle>=45 && groove_ramp_angle<=65);
assert(magnet_diameter+pocket_diameter_allowance>0 && pocket_chamfer>0);
assert(pocket_chamfer<magnet_thickness);
assert(magnet_radius+post_diameter/2<flange_diameter/2);
assert(post_diameter>magnet_diameter+pocket_diameter_allowance+3);
assert(holder_height-magnet_thickness-pocket_depth_allowance>=1.2);
assert(pin_projection>pin_chamfer && pin_projection<=flange_thickness-0.1);
assert(post_foot_diameter>=post_diameter && post_taper_height>0);
assert(pin_spacing>pin_diameter+1 && pin_clearance>0);
assert(2*pin_chamfer<pin_diameter);
assert(lug_spacing>post_diameter/2);
assert(pin_offset>=0 && pin_offset<lug_spacing);
assert(roof_start_z>1 && pin_roof_angle>=50 && pin_roof_angle<80);
assert(screw_step_height>=4.5 && screw_step_height<holder_height);
assert(roof_start_z<screw_step_height-0.8);
assert(screw_step_height<holder_height-magnet_thickness-pocket_depth_allowance);
assert(screw_lug_diameter>=8.4+1.6);
assert(mounting_hole_radius+lug_diameter/2<=flange_diameter/2);
assert(locating_lip_height>0 && locating_lip_height<magnet_boss_height-0.3);
assert(locating_clearance>=0.15 && locating_lip_chamfer>0);
assert(locating_recess_diameter+2*locating_lip_chamfer<=locating_lip_diameter-1.6+eps);
assert(!mounting_holes || mounting_hole_radius+mounting_hole_diameter/2<flange_diameter/2-1);
assert(cover_thickness>=1.2 && cover_diameter>2*magnet_radius+post_diameter+4);
assert(cover_diameter<=min(bed_width,bed_depth));
assert(cover_thickness+magnet_boss_height-magnet_thickness-pocket_depth_allowance>=0.6-1e-6);
assert(magnet_radius+magnet_boss_diameter/2<cover_diameter/2-2);
assert(magnet_boss_diameter>=magnet_diameter+pocket_diameter_allowance+2*pocket_chamfer+2);
echo(str("Cover diameter ",cover_diameter," mm, plate thickness ",cover_thickness," mm, total height ",cover_height," mm"));
echo(str("Holder seating height ",holder_height," mm, step height ",screw_step_height,
         " mm, magnet radius ",magnet_radius," mm, locating lip height ",locating_lip_height," mm"));
echo(str("Neck OD/ID ",OD," / ",ID," mm, flange thickness ",flange_thickness));
echo(str("Flange OD ",flange_diameter," mm, length from flange ",insertion_depth," mm, overall body depth ",body_depth," mm"));
echo(str("Groove depth ",groove_depth," mm, flat seat ",groove_width," mm, width including ramp ",groove_width+groove_ramp_height," mm, end offset ",groove_end_offset," mm"));

module radial_array(r, count, phase=0) {
    for(i=[0:count-1]) rotate([0,0,i*360/count+phase]) translate([r,0,0]) children();
}

module ring(d1,d2,h) {
    difference() {
        cylinder(d=d1,h=h);
        translate([0,0,-eps]) cylinder(d=d2,h=h+2*eps);
    }
}

module neck(h=insertion_depth) {
    difference() {
        union() {
            cylinder(d=OD,h=h-neck_chamfer);
            translate([0,0,h-neck_chamfer])
                cylinder(d1=OD,d2=OD-2*neck_chamfer,h=neck_chamfer);
        }
        translate([0,0,-eps]) cylinder(d=ID,h=h+2*eps);
    }
}

module seal_groove() {
    // The default groove has a 13.4 mm flat seat plus the ramp.
    ring(OD+2,OD-2*groove_depth,groove_width);
    translate([0,0,groove_width]) difference() {
        cylinder(d=OD+2,h=groove_ramp_height);
        cylinder(d1=OD-2*groove_depth,d2=OD,h=groove_ramp_height);
    }
}
module body() {
    difference() {
        union() {
            ring(flange_diameter,ID,flange_thickness);
            translate([0,0,flange_thickness-eps]) neck(insertion_depth+eps);
            threaded_seat();
        }
        translate([0,0,groove_z]) seal_groove();
        // Two through-holes per holder for the glued pins.
        radial_array(pin_radius,4,45)
            for(y=[-pin_spacing/2,pin_spacing/2])
                translate([0,y,-eps])
                    cylinder(d=pin_diameter+pin_clearance,h=flange_thickness+2*eps);
        if(mounting_holes) radial_array(mounting_hole_radius,4,45)
            translate([0,0,-eps]) cylinder(d=mounting_hole_diameter,h=flange_thickness+2*eps);
    }
}

module pin_socket() {
    // A 60-degree cone closes the pin socket without supports.
    // A small vent remains at the top of the 5 mm step.
    // The flat end meets the cone at approximately 3.5 mm insertion.
    translate([0,0,-eps]) cylinder(d=pin_hole_diameter,h=roof_start_z+eps);
    translate([0,0,roof_start_z])
        cylinder(d1=pin_hole_diameter,d2=0,h=pin_roof_height);
}
module magnet_holder() {
    difference() {
        union() {
            // Short rounded foot.
            hull() {
                cylinder(d=post_foot_diameter,h=screw_step_height);
                translate([lug_spacing,0,0]) cylinder(d=lug_diameter,h=screw_step_height);
            }
            cylinder(d=post_diameter,h=holder_height);
            // Only the locating rim flares out above the 11 mm post.
            translate([0,0,holder_height-lip_taper_height])
                cylinder(d1=post_diameter,d2=locating_lip_diameter,h=lip_taper_height+eps);
            translate([0,0,holder_height-eps])
                cylinder(d=locating_lip_diameter,h=locating_lip_height+eps);
            translate([0,0,screw_step_height-eps])
                cylinder(d1=post_foot_diameter,d2=post_diameter,h=post_taper_height+eps);
        }
        // Form the locating lip in the top of the post.
        translate([0,0,holder_height])
            cylinder(d=locating_recess_diameter,h=locating_lip_height+eps);
        translate([0,0,holder_height+locating_lip_height-locating_lip_chamfer])
            cylinder(d1=locating_recess_diameter,
                     d2=locating_recess_diameter+2*(locating_lip_chamfer+eps),
                     h=locating_lip_chamfer+eps);
        translate([0,0,holder_height-magnet_thickness-pocket_depth_allowance])
            cylinder(d=magnet_diameter+pocket_diameter_allowance,h=magnet_thickness+pocket_depth_allowance+eps);
        // Guide the magnet into the cylindrical press-fit pocket.
        translate([0,0,holder_height-pocket_chamfer])
            cylinder(d1=magnet_diameter+pocket_diameter_allowance,
                     d2=magnet_diameter+pocket_diameter_allowance+2*(pocket_chamfer+eps),
                     h=pocket_chamfer+eps);
        if(mounting_holes) translate([lug_spacing,0,-eps]) {
            cylinder(d=mounting_hole_diameter,h=screw_step_height+2*eps);
            translate([0,0,screw_step_height-2.2])
                cylinder(d1=mounting_hole_diameter,d2=8.4,h=2.2+2*eps);
        }
        for(y=[-pin_spacing/2,pin_spacing/2])
            translate([pin_offset,y,0]) pin_socket();
    }
}
module holder_pin() {
    // Print the pin standing on its flat end with the taper at the top.
    cylinder(d=pin_diameter,h=pin_length-pin_chamfer);
    translate([0,0,pin_length-pin_chamfer-eps])
        cylinder(d1=pin_diameter,d2=pin_diameter-2*pin_chamfer,
                 h=pin_chamfer+eps);
}
module holder_with_pins() {
    magnet_holder();
    for(y=[-pin_spacing/2,pin_spacing/2])
        translate([pin_offset,y,pin_bond_depth]) rotate([180,0,0]) holder_pin();
}
module printable_holder() {
    // Print with the foot on the bed and the magnet pocket facing up.
    magnet_holder();
}
module holder_set() {
    // One holder and two loose pins laid out for printing.
    printable_holder();
    for(y=[-4,4]) translate([-12,y,0]) holder_pin();
}


module cover_plate() {
    difference() {
        union() {
            cylinder(d=cover_diameter,h=cover_thickness);
            radial_array(magnet_radius,4,45)
                translate([0,0,cover_thickness-eps])
                    cylinder(d=magnet_boss_diameter,h=magnet_boss_height+eps);
        }
        radial_array(magnet_radius,4,45) {
            opening_z = cover_thickness+magnet_boss_height;
            translate([0,0,opening_z-magnet_thickness-pocket_depth_allowance])
                cylinder(d=magnet_diameter+pocket_diameter_allowance,
                         h=magnet_thickness+pocket_depth_allowance+eps);
            translate([0,0,opening_z-pocket_chamfer])
                cylinder(d1=magnet_diameter+pocket_diameter_allowance,
                         d2=magnet_diameter+pocket_diameter_allowance+2*(pocket_chamfer+eps),
                         h=pocket_chamfer+eps);
        }
    }
}
// Sample the helix at matching angles on successive horizontal slices.
body_thread_allowance=0.35; // Fixed reference allowance for the female thread in the body.
core_radius=ID/2-3.8;
bore_radius=core_radius-1.8;
tooth_height=1;
function thread_profile(a)=min(1,max(0,(150-abs((a%360+360)%360-180))/110));
module thread_envelope(z0,z1,clearance=0,lead_in=false) {
    n=120;
    slices=ceil((z1-z0)/thread_pitch*18);
    vertices=[for(k=[0:slices],i=[0:n-1])
        let(z=z0+k*(z1-z0)/slices,a=i*360/n,
            taper=lead_in?min(1,(z-z0)/1.2,(z1-z)/1.2):1,
            r=core_radius+clearance+tooth_height*taper*thread_profile(a-360*z/thread_pitch))
        [r*cos(a),r*sin(a),z]];
    polyhedron(points=vertices,faces=concat(
        [[for(i=[0:n-1]) i]],
        [for(k=[0:slices-1],i=[0:n-1],t=[0:1])
            let(a=k*n+i,b=k*n+(i+1)%n)
            t==0?[a,a+n,b+n]:[a,b+n,b]],
        [[for(i=[n-1:-1:0]) slices*n+i]]),convexity=16);
}
module threaded_seat(clearance=body_thread_allowance) {
    difference() {
        cylinder(r=ID/2+0.5,h=22);
        thread_envelope(-eps,22+eps,clearance);
        cylinder(r1=core_radius+clearance+1.5,r2=core_radius+clearance,h=1.5);
    }
}
module insert(clearance=insert_clearance) {
    assert(clearance>0 && core_radius+body_thread_allowance-clearance>bore_radius);
    difference() {
        union() {
            cylinder(r=core_radius,h=12.1);
            thread_envelope(12,32,body_thread_allowance-clearance,true);
        }
        translate([0,0,-eps]) cylinder(r=bore_radius,h=32+2*eps);
        // Shallow notches in the front edge engage the adjustment key.
        for(a=[0,180]) rotate(a) translate([bore_radius-1,-4,-eps]) cube([5,8,1.4+eps]);
    }
}
assert(thread_pitch>0 && body_thread_allowance>0 && extension>=0 && extension<=12);
assert(core_radius+tooth_height+body_thread_allowance<ID/2 && core_radius<magnet_radius-post_foot_diameter/2);
assert(12 < -cover_z-cover_thickness);
module assembly_model() {
    color("Ivory") body();
    color("DarkOrange") translate([0,0,-extension]) rotate(-360*extension/thread_pitch) insert();
    color("Silver") radial_array(magnet_radius,4,45) rotate([180,0,0]) holder_with_pins();
    color("LightBlue") translate([0,0,cover_z]) cover_plate();
}
if(part=="insert") insert();
else if(part=="body") body();
else if(part=="magnet_holder") printable_holder();
else if(part=="cover_plate") cover_plate();
else if(part=="assembly") assembly_model();
else difference(){assembly_model();translate([-200,-200,-50]) cube([400,200,150]);}
