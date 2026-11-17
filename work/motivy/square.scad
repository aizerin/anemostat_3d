// Z=0 je pohledova plocha limce; kladne Z smeruje do potrubi.
dil="rez"; // [rez,sestava,telo,vsuvka,kryci_talir,drzak_magnetu]
vysunuti=6; // [0:0.5:12]
stoupani=4;
vule_vsuvky=0.15; // Cilova radialni vule v puvodnim tele (mm).
/* [Telo] */
prumer_potrubi = 125;
prumer_hrdla = 115; // Zmereny vnejsi prumer, nezavisly na jmenovite trubce.
presah_lemu = 30; // Radialni presah za vnejsi stenu hrdla.
tloustka_lemu = 2;
hloubka_zasunuti = 35; // Delka trubky od ZADNI strany limce.
tloustka_steny = 3.9; // Pod drazkou hlubokou 2.5 mm zbyva 1.4 mm.
nabeh_hrdla = 1.2;
montazni_otvory = true;
prumer_montaznich_otvoru = 4.5;
polomer_montaznich_otvoru = 70;
/* [Drazka pro vlastni tesneni] */
sirka_tesneni = 13;
hloubka_drazky = 2.5;
vule_sirky_drazky = 0.4;
odsazeni_drazky_od_konce = 8; // Od konce hrdla po konec celeho sikmeho vybehu.
uhel_nabehu_drazky = 55; // Uhel vracejici se horni hrany od vodorovne roviny.
/* [Magnety a kotvici usi] */
prumer_magnetu = 6;
tloustka_magnetu = 3;
vule_magnetu = -0.10; // Diametralni presah 0.10 mm: kapsa 5.90 pro magnet 6 mm.
srazeni_kapsy_magnetu = 0.3; // Navadeci usti, plny presah zustava hloubeji.
hloubkova_vule_magnetu = 0.4; // Celkova rezerva pod magnetem.
polomer_magnetu = 58; // Uvnitr obrysu hrdla; kratka patka smerem ke sroubu.
prumer_drzaku = 11; // Pouze vysoky magnetovy sloupek.
vyska_schodu_sroubu = 5; // Nizka zakladna s uchem pro sroub.
prumer_ucha_sroubu = 10;
prumer_patky_magnetu = 13; // Pouze nizka obla patka; sloupek ma 11 mm.
vyska_nabehu_sloupku = 2; // Jemny prechod z patky na uzsi sloupek.
vyska_drzaku = 13; // Magnetova dosedaci rovina; nizky kulaty rantlik +1.2 mm.
polomer_cepu_drzaku = 63; // Nove ulozeni v kratke patce a v limci.
prumer_cepu_drzaku = 2.5;
delka_cepu_drzaku = 1.8;
roztec_cepu_drzaku = 6;
vule_cepu_drzaku = 0.3; // Diametralni vule pro pasovani a lepidlo.
nabeh_cepu_drzaku = 0.35;
hloubka_vlepeni_cepu = 3.5; // Oddeleny cep, plochym koncem dovnitr drzaku.
uhel_stresky_cepu = 60; // Strme vnitrni uzavreni otvoru pro tisk bez podpor.
/* [Skryte stredeni kolem magnetu] */
vyska_strediciho_osazeni = 1.2;
radialni_vule_stredeni = 0.4; // O dalsich 0.2 mm na kazdou stranu, diametralne 0.8 mm.
srazeni_strediciho_osazeni = 0.2;
/* [Kryci talir] */
okraj_podlozky = 1; // Rezerva na kazde strane pri vystredeni krytu (mm).
rozmer_podlozky_x = 248; // CORE One INDX
rozmer_podlozky_y = 205;
tloustka_krytu = 2;
prumer_luzka_magnetu_krytu = 8.6;
vyska_luzka_magnetu_krytu = 2; // Lokalni zesileni nad 2mm deskou.
/* [Tisk] */
kvalita = 192; // [96,160,192,256]
/* [Hidden] */
$fn = kvalita;
eps = 0.02;
OD = prumer_hrdla;
prumer_lemu = OD+2*presah_lemu;
celkova_hloubka_tela = tloustka_lemu+hloubka_zasunuti;
diametralni_vule = prumer_potrubi-OD;
ID = OD-2*tloustka_steny;
R = ID/2;
vrchol = tloustka_lemu+hloubka_zasunuti;
sir_drazky = sirka_tesneni+vule_sirky_drazky;
vyska_nabehu_drazky = hloubka_drazky*tan(uhel_nabehu_drazky);
z_drazky = vrchol-odsazeni_drazky_od_konce-sir_drazky-vyska_nabehu_drazky;
roztec_ucha = polomer_montaznich_otvoru-polomer_magnetu;
posun_cepu = polomer_cepu_drzaku-polomer_magnetu;
prumer_ucha = prumer_ucha_sroubu;
prumer_otvoru_cepu = prumer_cepu_drzaku+vule_cepu_drzaku;
z_zacatek_stresky = hloubka_vlepeni_cepu-vule_cepu_drzaku/2*tan(uhel_stresky_cepu);
vyska_stresky_cepu = prumer_otvoru_cepu/2*tan(uhel_stresky_cepu);
delka_samostatneho_cepu = hloubka_vlepeni_cepu+delka_cepu_drzaku;
prumer_krytu = min(rozmer_podlozky_x,rozmer_podlozky_y)-2*okraj_podlozky;
vyska_krytu = tloustka_krytu+vyska_luzka_magnetu_krytu;
// Krytova luzka dosednou na rovinu magnetu, kulata osazeni je obejmou zboku.
z_krytu = -vyska_drzaku-vyska_luzka_magnetu_krytu-tloustka_krytu;
prumer_stredici_dutiny = prumer_luzka_magnetu_krytu+2*radialni_vule_stredeni;
prumer_strediciho_okraje = max(prumer_drzaku,prumer_stredici_dutiny+2); // Zachovat 1mm stenu.
vyska_nabehu_okraje = max(eps,(prumer_strediciho_okraje-prumer_drzaku)/2);
assert(OD>0 && ID>0 && diametralni_vule>=0);
assert(tloustka_lemu>=2 && prumer_lemu>OD);
assert(tloustka_steny-hloubka_drazky>=1.2);
assert(celkova_hloubka_tela>tloustka_lemu+10);
assert(z_drazky>tloustka_lemu+1);
assert(odsazeni_drazky_od_konce>nabeh_hrdla);
assert(uhel_nabehu_drazky>=45 && uhel_nabehu_drazky<=65);
assert(prumer_magnetu+vule_magnetu>0 && srazeni_kapsy_magnetu>0);
assert(srazeni_kapsy_magnetu<tloustka_magnetu);
assert(polomer_magnetu+prumer_drzaku/2<prumer_lemu/2);
assert(prumer_drzaku>prumer_magnetu+vule_magnetu+3);
assert(vyska_drzaku-tloustka_magnetu-hloubkova_vule_magnetu>=1.2);
assert(delka_cepu_drzaku>nabeh_cepu_drzaku && delka_cepu_drzaku<=tloustka_lemu-0.1);
assert(prumer_patky_magnetu>=prumer_drzaku && vyska_nabehu_sloupku>0);
assert(roztec_cepu_drzaku>prumer_cepu_drzaku+1 && vule_cepu_drzaku>0);
assert(2*nabeh_cepu_drzaku<prumer_cepu_drzaku);
assert(roztec_ucha>prumer_drzaku/2);
assert(posun_cepu>=0 && posun_cepu<roztec_ucha);
assert(z_zacatek_stresky>1 && uhel_stresky_cepu>=50 && uhel_stresky_cepu<80);
assert(vyska_schodu_sroubu>=4.5 && vyska_schodu_sroubu<vyska_drzaku);
assert(z_zacatek_stresky<vyska_schodu_sroubu-0.8);
assert(vyska_schodu_sroubu<vyska_drzaku-tloustka_magnetu-hloubkova_vule_magnetu);
assert(prumer_ucha_sroubu>=8.4+1.6);
assert(polomer_montaznich_otvoru+prumer_ucha/2<=prumer_lemu/2);
assert(vyska_strediciho_osazeni>0 && vyska_strediciho_osazeni<vyska_luzka_magnetu_krytu-0.3);
assert(radialni_vule_stredeni>=0.15 && srazeni_strediciho_osazeni>0);
assert(prumer_stredici_dutiny+2*srazeni_strediciho_osazeni<=prumer_strediciho_okraje-1.6+eps);
assert(!montazni_otvory || polomer_montaznich_otvoru+prumer_montaznich_otvoru/2<prumer_lemu/2-1);
assert(tloustka_krytu>=1.2 && prumer_krytu>2*polomer_magnetu+prumer_drzaku+4);
assert(prumer_krytu<=min(rozmer_podlozky_x,rozmer_podlozky_y));
assert(tloustka_krytu+vyska_luzka_magnetu_krytu-tloustka_magnetu-hloubkova_vule_magnetu>=0.6-1e-6);
assert(polomer_magnetu+prumer_luzka_magnetu_krytu/2<prumer_krytu/2-2);
assert(prumer_luzka_magnetu_krytu>=prumer_magnetu+vule_magnetu+2*srazeni_kapsy_magnetu+2);
echo(str("Kryt: prumer ",prumer_krytu," mm, deska ",tloustka_krytu," mm, celkem ",vyska_krytu," mm"));
echo(str("Drzaky: magnetova plocha ",vyska_drzaku," mm, kratka patka ",vyska_schodu_sroubu,
         " mm, magnety R ",polomer_magnetu," mm, skryte kruhove osazeni ",vyska_strediciho_osazeni," mm"));
echo(str("Hrdlo OD/ID: ",OD," / ",ID," mm; lem ",tloustka_lemu));
echo(str("Limec OD ",prumer_lemu," mm; delka od limce ",hloubka_zasunuti," mm; telo celkem ",celkova_hloubka_tela," mm"));
echo(str("Drazka: hloubka ",hloubka_drazky," mm; rovne dno ",sir_drazky," mm; celkem s nabehem ",sir_drazky+vyska_nabehu_drazky," mm; odsazeni od konce ",odsazeni_drazky_od_konce," mm"));

module na_kruznici(r, pocet, posun=0) {
    for(i=[0:pocet-1]) rotate([0,0,i*360/pocet+posun]) translate([r,0,0]) children();
}

module prstenec(d1,d2,h) {
    difference() {
        cylinder(d=d1,h=h);
        translate([0,0,-eps]) cylinder(d=d2,h=h+2*eps);
    }
}

module hrdlo(h=hloubka_zasunuti) {
    difference() {
        union() {
            cylinder(d=OD,h=h-nabeh_hrdla);
            translate([0,0,h-nabeh_hrdla])
                cylinder(d1=OD,d2=OD-2*nabeh_hrdla,h=nabeh_hrdla);
        }
        translate([0,0,-eps]) cylinder(d=ID,h=h+2*eps);
    }
}

module drazka_tesneni() {
    // Plne rovne dno pro tesneni zustava 13.4 mm. Nabeh je navic nad nim.
    prstenec(OD+2,OD-2*hloubka_drazky,sir_drazky);
    translate([0,0,sir_drazky]) difference() {
        cylinder(d=OD+2,h=vyska_nabehu_drazky);
        cylinder(d1=OD-2*hloubka_drazky,d2=OD,h=vyska_nabehu_drazky);
    }
}
module telo() {
    difference() {
        union() {
            prstenec(prumer_lemu,ID,tloustka_lemu);
            translate([0,0,tloustka_lemu-eps]) hrdlo(hloubka_zasunuti+eps);
            sedlo_se_zavitem();
        }
        translate([0,0,z_drazky]) drazka_tesneni();
        // Dva pruchozi otvory pro lepici cepy kazdeho drzaku.
        na_kruznici(polomer_cepu_drzaku,4,45)
            for(y=[-roztec_cepu_drzaku/2,roztec_cepu_drzaku/2])
                translate([0,y,-eps])
                    cylinder(d=prumer_cepu_drzaku+vule_cepu_drzaku,h=tloustka_lemu+2*eps);
        if(montazni_otvory) na_kruznici(polomer_montaznich_otvoru,4,45)
            translate([0,0,-eps]) cylinder(d=prumer_montaznich_otvoru,h=tloustka_lemu+2*eps);
    }
}

module otvor_pro_vlepeni_cepu() {
    // Otvor pro cep; 60st kuzel vytvari samonosne zuzeni.
    // V 5mm schodu zustava nahore maly odvetravaci otvor; ulozeni cepu se nemeni.
    // Plochy konec cepu se opre o kuzel pri zasunuti priblizne 3.5 mm.
    translate([0,0,-eps]) cylinder(d=prumer_otvoru_cepu,h=z_zacatek_stresky+eps);
    translate([0,0,z_zacatek_stresky])
        cylinder(d1=prumer_otvoru_cepu,d2=0,h=vyska_stresky_cepu);
}
module drzak_magnetu() {
    difference() {
        union() {
            // Kratka obla patka bez vystupku pro stare otvory.
            hull() {
                cylinder(d=prumer_patky_magnetu,h=vyska_schodu_sroubu);
                translate([roztec_ucha,0,0]) cylinder(d=prumer_ucha,h=vyska_schodu_sroubu);
            }
            cylinder(d=prumer_drzaku,h=vyska_drzaku);
            // Jen nizky kruhovy okraj je sirsi; vlastni sloupek zustava 11 mm.
            translate([0,0,vyska_drzaku-vyska_nabehu_okraje])
                cylinder(d1=prumer_drzaku,d2=prumer_strediciho_okraje,h=vyska_nabehu_okraje+eps);
            translate([0,0,vyska_drzaku-eps])
                cylinder(d=prumer_strediciho_okraje,h=vyska_strediciho_osazeni+eps);
            translate([0,0,vyska_schodu_sroubu-eps])
                cylinder(d1=prumer_patky_magnetu,d2=prumer_drzaku,h=vyska_nabehu_sloupku+eps);
        }
        // Nizke kulate osazeni je soucasti sloupku, nikoli samostatna stena.
        translate([0,0,vyska_drzaku])
            cylinder(d=prumer_stredici_dutiny,h=vyska_strediciho_osazeni+eps);
        translate([0,0,vyska_drzaku+vyska_strediciho_osazeni-srazeni_strediciho_osazeni])
            cylinder(d1=prumer_stredici_dutiny,
                     d2=prumer_stredici_dutiny+2*(srazeni_strediciho_osazeni+eps),
                     h=srazeni_strediciho_osazeni+eps);
        translate([0,0,vyska_drzaku-tloustka_magnetu-hloubkova_vule_magnetu])
            cylinder(d=prumer_magnetu+vule_magnetu,h=tloustka_magnetu+hloubkova_vule_magnetu+eps);
        // Siroke usti navede magnet do tesne valcove kapsy.
        translate([0,0,vyska_drzaku-srazeni_kapsy_magnetu])
            cylinder(d1=prumer_magnetu+vule_magnetu,
                     d2=prumer_magnetu+vule_magnetu+2*(srazeni_kapsy_magnetu+eps),
                     h=srazeni_kapsy_magnetu+eps);
        if(montazni_otvory) translate([roztec_ucha,0,-eps]) {
            cylinder(d=prumer_montaznich_otvoru,h=vyska_schodu_sroubu+2*eps);
            translate([0,0,vyska_schodu_sroubu-2.2])
                cylinder(d1=prumer_montaznich_otvoru,d2=8.4,h=2.2+2*eps);
        }
        for(y=[-roztec_cepu_drzaku/2,roztec_cepu_drzaku/2])
            translate([posun_cepu,y,0]) otvor_pro_vlepeni_cepu();
    }
}
module cep_drzaku() {
    // Tisk na plochy konec, nahore jen zuzeni. Zadny nepodepreny schod.
    cylinder(d=prumer_cepu_drzaku,h=delka_samostatneho_cepu-nabeh_cepu_drzaku);
    translate([0,0,delka_samostatneho_cepu-nabeh_cepu_drzaku-eps])
        cylinder(d1=prumer_cepu_drzaku,d2=prumer_cepu_drzaku-2*nabeh_cepu_drzaku,
                 h=nabeh_cepu_drzaku+eps);
}
module drzak_s_cepy() {
    drzak_magnetu();
    for(y=[-roztec_cepu_drzaku/2,roztec_cepu_drzaku/2])
        translate([posun_cepu,y,hloubka_vlepeni_cepu]) rotate([180,0,0]) cep_drzaku();
}
module drzak_pro_tisk() {
    // Rovnou zakladnou na podlozku; magnetova kapsa a rantl nahoru.
    drzak_magnetu();
}
module drzak_sada() {
    // Jedna sada: celek drzaku a dva samostatne cepy vedle nej.
    drzak_pro_tisk();
    for(y=[-4,4]) translate([-12,y,0]) cep_drzaku();
}


module kryci_talir() {
    difference() {
        union() {
            linear_extrude(tloustka_krytu) offset(r=2) square([prumer_krytu-4,prumer_krytu-4],center=true);
            na_kruznici(polomer_magnetu,4,45)
                translate([0,0,tloustka_krytu-eps])
                    cylinder(d=prumer_luzka_magnetu_krytu,h=vyska_luzka_magnetu_krytu+eps);
        }
        na_kruznici(polomer_magnetu,4,45) {
            z_usti = tloustka_krytu+vyska_luzka_magnetu_krytu;
            translate([0,0,z_usti-tloustka_magnetu-hloubkova_vule_magnetu])
                cylinder(d=prumer_magnetu+vule_magnetu,
                         h=tloustka_magnetu+hloubkova_vule_magnetu+eps);
            translate([0,0,z_usti-srazeni_kapsy_magnetu])
                cylinder(d1=prumer_magnetu+vule_magnetu,
                         d2=prumer_magnetu+vule_magnetu+2*(srazeni_kapsy_magnetu+eps),
                         h=srazeni_kapsy_magnetu+eps);
        }
    }
}
// Sroubovice jako soustava vodorovnych prurezu; vzorky maji shodny azimut.
vule_zavitu=0.35; // Pevny referencni profil vnitrniho zavitu tela.
r_jadra=ID/2-3.8;
r_otvor=r_jadra-1.8;
vyska_zubu=1;
function profil(a)=min(1,max(0,(150-abs((a%360+360)%360-180))/110));
module obal_zavitu(z0,z1,vule=0,nabeh=false) {
    n=120;
    vrstvy=ceil((z1-z0)/stoupani*18);
    body=[for(k=[0:vrstvy],i=[0:n-1])
        let(z=z0+k*(z1-z0)/vrstvy,a=i*360/n,
            faktor=nabeh?min(1,(z-z0)/1.2,(z1-z)/1.2):1,
            r=r_jadra+vule+vyska_zubu*faktor*profil(a-360*z/stoupani))
        [r*cos(a),r*sin(a),z]];
    polyhedron(points=body,faces=concat(
        [[for(i=[0:n-1]) i]],
        [for(k=[0:vrstvy-1],i=[0:n-1],t=[0:1])
            let(a=k*n+i,b=k*n+(i+1)%n)
            t==0?[a,a+n,b+n]:[a,b+n,b]],
        [[for(i=[n-1:-1:0]) vrstvy*n+i]]),convexity=16);
}
module sedlo_se_zavitem(vule=vule_zavitu) {
    difference() {
        cylinder(r=ID/2+0.5,h=22);
        obal_zavitu(-eps,22+eps,vule);
        cylinder(r1=r_jadra+vule+1.5,r2=r_jadra+vule,h=1.5);
    }
}
module vsuvka(vule=vule_vsuvky) {
    assert(vule>0 && r_jadra+vule_zavitu-vule>r_otvor);
    difference() {
        union() {
            cylinder(r=r_jadra,h=12.1);
            obal_zavitu(12,32,vule_zavitu-vule,true);
        }
        translate([0,0,-eps]) cylinder(r=r_otvor,h=32+2*eps);
        // Melke hmatove vyrezy v predni hrane pro otaceni.
        for(a=[0,180]) rotate(a) translate([r_otvor-1,-4,-eps]) cube([5,8,1.4+eps]);
    }
}
assert(stoupani>0 && vule_zavitu>0 && vysunuti>=0 && vysunuti<=12);
assert(r_jadra+vyska_zubu+vule_zavitu<ID/2 && r_jadra<polomer_magnetu-prumer_patky_magnetu/2);
assert(12 < -z_krytu-tloustka_krytu);
module komplet() {
    color("Ivory") telo();
    color("DarkOrange") translate([0,0,-vysunuti]) rotate(-360*vysunuti/stoupani) vsuvka();
    color("Silver") na_kruznici(polomer_magnetu,4,45) rotate([180,0,0]) drzak_s_cepy();
    color("LightBlue") translate([0,0,z_krytu]) kryci_talir();
}
if(dil=="vsuvka") vsuvka();
else if(dil=="telo") telo();
else if(dil=="drzak_magnetu") drzak_pro_tisk();
else if(dil=="kryci_talir") kryci_talir();
else if(dil=="sestava") komplet();
else difference(){komplet();translate([-200,-200,-50]) cube([400,200,150]);}
