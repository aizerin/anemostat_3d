// Kratke vzorky ze stejne geometrie jako kompletni ventil, v tiskove orientaci.
use <ventil.scad>
$fn = 192; // Stejne rozliseni kruznic jako u celeho ventilu.
vzorek = "oba"; // [oba,telo,vsuvka]
vyska = 8; // dve stoupani zavitu
vule_vzorku = 0.15; // Radialni vule v mm.
module vzorek_tela() {
    intersection() {
        sedlo_se_zavitem();
        translate([-60,-60,0]) cube([120,120,vyska]);
    }
}
module vzorek_vsuvky() {
    // Posledni cast vsuvky vcetne puvodniho nabehu, kterym vstupuje do tela.
    intersection() {
        translate([0,0,vyska-32]) vsuvka(vule_vzorku);
        translate([-60,-60,0]) cube([120,120,vyska+0.1]);
    }
}
if(vzorek=="telo") vzorek_tela();
else if(vzorek=="vsuvka") vzorek_vsuvky();
else {
    translate([-55,0,0]) vzorek_tela();
    translate([55,0,0]) vzorek_vsuvky();
}
