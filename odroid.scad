odroid_width = 59;
odroid_height = 60;
odroid_depth=57;

module odroid_u2() {

  width = 59;
  height = 60;
  depth = 57;

  // heat sink
  color("gray") {
    cube([2, height, depth]);
    translate([width-2, 0, 0]) cube([2, height, depth]);
    translate([0, 0, 14]) cube([width, height, 3]);
    translate([26, 0, 17]) cube([24, height, 2]);
    // bones
    for(x=[10,16, 23, 29, 35, 41, 47]) {
      translate([x, 0, 0]) cube([1.5, height, 14]);
    }
  }

  pcb_w = 51;
  pcb_h = 48;
  pcb_d = 1;

  pcb_offset = 14+3+2+2;
  pcb_level = pcb_offset+pcb_d;

  // pcb
  color("green") translate([3, 6, pcb_offset]) cube([pcb_w, pcb_h, pcb_d]);

  // lan + usb
  color("Gainsboro") translate([5.5, 0.5, pcb_offset+pcb_d+1]) cube([19, 27.5, 30]);
  color("black") {
    translate([8, 0, 25]) cube([13, 1, 5]);
    translate([8, 0, 33]) cube([13, 1, 5]);
    translate([8, 0, 43]) cube([13, 1, 8]);
  }

  // sdhc
  color("Gainsboro") translate([43, 6, pcb_level]) cube([10, 15, 3.5]);

  // audio
  color("black") translate([3, 42, pcb_level]) cube([7, 12, 12]);

  // power
  color("Gainsboro") translate([16, 48, pcb_level]) cube([4, 6, 3.5]);

  // hdmi
  color("Gainsboro") translate([33, 48, pcb_level]) cube([5, 6, 3]);

  // micro usb
  color("Gainsboro") translate([48, 49, pcb_level]) cube([6, 5, 3]);

  // uart
  color("ivory") translate([49.5, 30, pcb_level]) cube([4.5, 12, 6]);
}

module odroid_support() {
  w = 15;
  h = 2;
  depth=25;
  thick = 4;
  level = 13.5;

  // pcb
  color("white") difference() {
    cube([w, h, depth]);
    translate([-1, -1, level]) cube([6, h+2, thick]);
  }

  // screw  hole
  color("white") difference() {
    translate([5, 0, 0]) cube([w-5, 10, 4]);
    translate([10, 6, -1]) cylinder(r=2, h=6);
  }

  // screw
  color("gray") translate([10, 6, -6]) cylinder(r=1.5, h=12);


}

module odroid_glass() {
  offset = 10;
  % translate([-offset, -offset, odroid_depth+5]) cube([odroid_width+offset*2, odroid_height+offset*2, 2]);
  color("gray") for(x=[-offset/2, odroid_width+offset/2]) for(y=[-offset/2, odroid_height+offset/2]) {
    translate([x, y, -10]) cylinder(r=1.5, h=80);
  }
}

module odroid_supports() {

  translate([3,5,0]) rotate([0,0,270]) odroid_support();

  translate([59-3,5,0]) rotate([0,0,270]) mirror([0,1,0]) odroid_support();

  translate([3,60-5,0]) rotate([0,0,90]) mirror([0,1,0])odroid_support();

  translate([59-3,60-5,0]) rotate([0,0,90])  odroid_support();

  // translate([0,0,0]) rotate([0,0,90]) odroid_support();
  
}

module odroid_wires() {
  color("yello") {
    translate([38, -25,5]) cube([14, 25, 14]);
    translate([45, -25, 10]) rotate([90,0,0]) cylinder(r=2, h=25);
    translate([45, -50, -20])  cylinder(r=2, h=32);
  }
  // power
  color("black") {
    translate([38.5, odroid_height, 30]) cube([5, 30,5]);
    //translate([18, odroid_height+20+10, -10]) cylinder(r=2.5, h=35);
  }
}

module odroid_supports(screw_radius, mode) {
  offset = 5;

  if(mode=="center") {
    translate([odroid_width/4,-offset,-20]) cylinder(r=screw_radius, h=60);
    translate([odroid_width+offset, odroid_height/2,-20]) cylinder(r=screw_radius, h=60);
  } else {
    translate([odroid_width/2,-offset,-20]) cylinder(r=screw_radius, h=60);
    translate([odroid_width+offset, odroid_height+offset,-20]) cylinder(r=screw_radius, h=60);
  }
     translate([-offset-5, odroid_height+1,-20]) cylinder(r=screw_radius, h=60);


}

module odroid_full(type, screw_radius, mode, ether_hole_offset=0) {

  if(type=="model") {
    translate([odroid_width, 0, odroid_depth]) rotate([180, 0, 180]) odroid_u2();
    // odroid_supports();
    // odroid_glass();
    odroid_wires();
    odroid_supports(screw_radius, mode);
  }
 
  if(type=="holes"){
  
    translate([45+ether_hole_offset, -50, -20])  cube(size=[25, 15, 57], center=true); 
    odroid_supports(screw_radius, mode);
  }

  if(type=="footprint"){
    translate([0, 0, -50]) cube([odroid_width, odroid_height, 100]);
  }

}


// odroid_full("footprint");
// odroid_full("model", 1.5);
// odroid_full("holes", 2);
