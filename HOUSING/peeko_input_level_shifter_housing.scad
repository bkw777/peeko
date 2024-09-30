/*
 * Housing for PEEKO input level shifter
 */

mil = 0.0254;
//mw = 0.8; // minimum allowed wall thickness
fc = 0.2;   // fitment clearance
e = 0.1;    // epsilon (overlap/overcut)


pcb_w = 1700*mil;   // X
pcb_d = 720*mil;    // Y
pcb_h = 1.6;        // Z
pcb_r = 0;          // corner radius

components_h = 100*mil+fc;
retainer_radius = 0.8;
wt = 1;            // wall thickness
cr = 0.5;          // corner/fillet radius
hr = wt*2;
vr = wt;


// z=0 is the bottom surface of the pcb

//$fa = 2;
//$fs = 0.1;
$fn = 36;



// =================================================================

use <inc/handy.scad>

module fit_parts() {
  import("inc/peeko_input_level_shifter.stl");
}

module body () {
     difference() {

      // add
      // exterior
      hull () {
        // bottom
        translate([0,0,hr-components_h-fc-wt])
          rotate([90,0,0])
            rounded_cube(w=wt*2+fc*2+pcb_w,h=pcb_d,d=wt*4,rh=hr,rv=vr,t=0);
        // top
        translate([0,0,-hr+pcb_h+components_h])
          rotate([0,90,0])
            rounded_cube(h=wt*2+fc*2+pcb_w,d=pcb_d,w=wt*4,rh=hr,rv=vr,t=0);
      }

      // cut
      union () {
      _h = 20;

      // main cavity
      translate([0,0,_h/2-components_h-fc])
        rotate([90,0,0])
          rounded_cube(w=pcb_w+fc*2,h=pcb_d+wt*4,d=_h,rh=vr,rv=vr,t=0);

        // vref
        translate([pcb_w/2+fc,0,pcb_h+50*mil])
          rounded_cube(d=cr+200*mil+cr,w=wt*4,h=cr+100*mil+cr,rh=cr,rv=cr,t=0);

      }
    }

    // retainers
    rl = pcb_d/2-100*mil-cr-wt*2;
    rr = retainer_radius;
    oy = 5.2; // offset y

    mirror_copy([0,1,0])
      mirror_copy([1,0,0]) {
        translate([pcb_w/2+fc,oy,rr+pcb_h+fc])
          rotate([90,0,0])
            cylinder(h=rl-e,r=rr,center=true);
    }

    // ribs
    mirror_copy([0,1,0])
    translate([0,oy,-components_h/2-fc])
      cube([pcb_w+fc*2+e*2,wt,components_h],center=true);

    // female side corner stops
    ir = vr+fc+e;
    _w = 3.5;
    _h = components_h + fc;
    mirror_copy([0,1,0])
    mirror_copy([1,0,0])
    translate([-pcb_w/2+_w/2-fc-fc,pcb_d/2-0.05,-_h/2-fc])
      rotate([90,0,0])
        translate([ir-_w/2,ir-_h/2,0])
          hull () {
            cylinder(h=wt,r=ir);
            translate([-ir,-ir-1+_h,0]) cube([1,1,wt]);
            translate([-1-ir+_w,-ir-1+_h,0]) cube([1,1,wt]);
            translate([-1-ir+_w,-ir,0]) cube([1,1,wt]);
          }
}


// =================================================================

%fit_parts();
body();
