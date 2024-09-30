/*
 * Housing for PEEKO
 */

mil = 0.0254;
//mw = 0.8; // minimum allowed wall thickness
fc = 0.2;   // fitment clearance
e = 0.1;    // epsilon (overlap/overcut)


pcb_w = 2050*mil;   // X
pcb_d = 1700*mil;   // Y
pcb_h = 1.6;        // Z
pcb_r = 100*mil;    // corner radius

components_h = 2.8;
retainer_radius = 0.8;
ledge_width = 0.5; // ledge width
wt = 1;          // wall thickness
cr = 0.5;        // corner/fillet radius
er = fc+wt;

// z=0 is the bottom surface of the pcb
above_ih = pcb_h + components_h;
below_ih = components_h;

//$fa = 2;
//$fs = 0.1;
$fn = 36;

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
  import("inc/peeko+.stl");
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
        translate([0,0,ih/2-below_eh+wt]) rounded_cube(w=pcb_w-lw*2,d=pcb_d-lw*2,h=ih,rh=pcb_r-lw,rv=er-wt,t=0);

        // idc
        _w = cr+45.628+cr;
        _d = 12;
        _h = cr+9.2+1+cr;;
        translate([0,-pcb_d/2-_d/2,pcb_h/2]) rounded_cube(w=_w,d=_d,h=_h,rh=cr,rv=cr,t=0);
        translate([0,-pcb_d/2-_d/2+lw+cr+1,pcb_h/2]) rounded_cube(w=1450*mil,d=_d,h=150*mil,rh=cr,rv=cr,t=0);

        // usb
        uw = cr+8+cr;
        ud = 14;
        uh = 8;
        uy = 470*mil; // pcb edge to usb center
        translate([-pcb_w/2,pcb_d/2-uy,pcb_h+2.4]) rounded_cube(w=uw,d=ud,h=uh,rh=2,rv=2,t=0);

        // chain
        cx = 650*mil; // pcb edge to pin header center
        x = fc+wt+cr+e;
        pz = eh/2+pcb_h-cr;
        translate([0,-pcb_d/2+cx,pz])
          rounded_cube(d=cr+200*mil+cr,w=x+pcb_w+x,h=eh,rh=cr,rv=cr,t=0);

        // vref
        vx = 350*mil; // pcb edge to pin center
        ve = 4; // extra width on opne side to join with other hole
        vd = cr+300*mil+cr +ve;
        translate([pcb_w/2+fc,-pcb_d/2+vx +ve/2,pz])
          rounded_cube(w=cr+1+wt*2+1+cr,d=vd,h=eh,rh=cr,rv=cr,t=0);

        // debugging cutaway
        //translate([0,ed/4+e/2,eh/2-below_eh-wt-e]) cube([e+ew+e,ed/2+e,e+eh+e],center=true);

      }
    }
    
    // retainers
    rl = 30; // long cylinder in rear wall
    rs = 2.1;  // short cylinders in front corners
    rr = retainer_radius;
    rz = pcb_h+rr+fc;
    thr = pcb_r+fc; // torus horizontal radius

    mirror_copy([1,0,0]) {
      // short cylinders in front corners
      translate([pcb_w/2+fc,-pcb_d/2+pcb_r+rs/2-e,rz])
        rotate([90,0,0])
          cylinder(h=rs,r=rr,center=true);
      // 1/4 tourus in front corners
      translate([-pcb_w/2-fc+thr,-pcb_d/2-fc+thr,rz])
      rotate([0,0,180])
      intersection() {
        translate([0,0,-thr]) cube(thr*2);
        torus(rh=thr,rv=rr);
      }
    }

    // long cylinder in rear wall
    translate([0,pcb_d/2+fc,rz])
      rotate([0,90,0])
        cylinder(h=pcb_w/2-pcb_r,r=rr,center=true);

}

// =================================================================

%fit_parts();
body();
