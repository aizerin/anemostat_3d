// Rucni klic pro vsuvku DN125. Tisk v zobrazene poloze, vedenim nahoru.
// Z=0 je strana smerem k uzivateli. V cele vsuvky je pri nasazeni Z=vyska_uchopu.
otvor = 96;
radialni_vule = 0.35;
hloubka_vedeni = 6;
sirka_zubu = 7.4; // Vyrez ve vsuvce je siroky 8 mm.
vyska_zubu = 1.2; // Hloubka vyrezu je 1.4 mm.
vyska_uchopu = 14;
sirka_pricky = 12;
$fn = 192;
r_vedeni = otvor/2-radialni_vule;
r_ramu = otvor/2+1.65;
r_uvnitr = r_vedeni-2.8;
eps = 0.02;

module venec() {
    rotate_extrude() polygon([
        [r_uvnitr,0], [r_ramu-0.6,0], [r_ramu,0.6],
        [r_ramu,vyska_uchopu], [r_vedeni,vyska_uchopu],
        [r_vedeni,vyska_uchopu+hloubka_vedeni-1],
        [r_vedeni-1,vyska_uchopu+hloubka_vedeni],
        [r_uvnitr,vyska_uchopu+hloubka_vedeni]]);
}
module prickovy_uchop() {
    // Zaoblene hrany pricky v miste dotyku s prsty.
    rotate([90,0,90]) linear_extrude(height=2*(r_uvnitr+1),center=true)
        offset(r=1) offset(delta=-1)
            square([sirka_pricky,vyska_uchopu],center=true);
}
module klic() {
    union() {
        venec();
        translate([0,0,vyska_uchopu/2]) prickovy_uchop();
        for(a=[0,180]) rotate(a) intersection() {
            translate([r_uvnitr,-sirka_zubu/2,vyska_uchopu-eps])
                cube([r_ramu-r_uvnitr,sirka_zubu,vyska_zubu+eps]);
            cylinder(r=r_ramu,h=vyska_uchopu+vyska_zubu);
        }
    }
}
klic();
