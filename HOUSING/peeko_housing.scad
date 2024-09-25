/*
 * Housing for PEEKO
 */

mil = 0.0254;

pcb_w = 830*mil;    // X
pcb_d = 2020*mil;   // Y
pcb_h = 1.6;        // Z
pcb_r = 0; // 50*mil; // peeko has radius but pico has sharp corners

pin_header_insulator_height = 100*mil;
pico_pcb_thickness = 1;
pico_components_h = 1.6;

// z=0 is the bottom surface of the peeko pcb
above_ih = pcb_h + pin_header_insulator_height + pico_pcb_thickness + pico_components_h;
below_ih = 8;

wt = 1;          // wall thickness
cr = 0.5;        // corner/fillet radius
ledge_width = 0.5; // ledge width

//mw = 0.8; // minimum allowed wall thickness
fc = 0.2;   // fitment clearance
e = 0.1;    // epsilon (overlap/overcut)
//$fa = 2;
//$fs = 0.1;
$fn = 36;

er = fc+wt;
ew = er+pcb_w+er;
ed = er+pcb_d+er;
ih = below_ih + above_ih;
above_eh = above_ih + er;
below_eh = below_ih + er;
eh = below_eh + above_eh;
lw = ledge_width + fc;


// =================================================================

use <inc/handy.scad>

module fit_parts() {
  import("inc/peeko.stl");
}

module body () {
     difference() {

      // add
      // exterior
      translate([0,0,eh/2-below_eh]) rounded_cube(w=ew,d=ed,h=eh,rh=pcb_r+er,rv=er,t=0);

      // cut
      union () {
        // pcb cavity
        translate([0,0,eh/2-fc]) rounded_cube(w=fc+pcb_w+fc,d=fc+pcb_d+fc,h=eh,rh=pcb_r+fc,rv=fc,t=0);

        // bottom cavity
        translate([0,0,ih/2-below_eh+wt]) rounded_cube(w=pcb_w-lw*2,d=pcb_d-lw*2,h=ih,rh=50*mil,rv=50*mil,t=0);

        // idc
        _w = 10;
        _d = cr+45.75+cr;
        _h = cr+9.2+1+cr;;
        translate([_w/2+3.11-cr,-100*mil,-_h/2+cr]) rounded_cube(w=_w,d=_d,h=_h,rh=cr,rv=cr,t=0);

        // usb
        uw = cr+7.5+cr;
        ud = 10;
        uh = 10;
        translate([0,pcb_d/2,uh/2+pcb_h + pin_header_insulator_height + pico_pcb_thickness - cr]) rounded_cube(w=uw,d=ud,h=uh,rh=2,rv=2,t=0);

        // chain
        r = 2;
        x = fc+wt+r+1;
        translate([-200*mil,0,-50*mil]) rounded_cube(w=cr+200*mil+cr,d=x+pcb_d+x,h=cr+100*mil+cr,rh=cr,rv=cr,t=0);

        // debugging cutaway
        //translate([0,ed/4+e/2,eh/2-below_eh-wt-e]) cube([e+ew+e,ed/2+e,e+eh+e],center=true);

      }
    }
    
    // retainers
    rl = 30;
    rr = wt;
    mirror_copy([1,0,0])
      translate([pcb_w/2+fc,0,pcb_h+pin_header_insulator_height+pico_pcb_thickness+rr+fc])
        rotate([90,0,0])
          cylinder(h=rl,r=rr,center=true);

}

// =================================================================

%fit_parts();
body();
