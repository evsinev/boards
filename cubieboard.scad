cubieboard_width=100;
cubieboard_height=59;

module cubieboard() {
  width = 100;
  height = 59;
  // pcb
  difference() {
    color([0.1, 0.1, 0.1]) translate([0, 0, -1]) cube([width, height, 1]);
    color ("yellow") for(x=[22, width-3]) for(y=[3, height-3]) {
         cubieboard_screws(1.5);
    }
  }

  // micro sd
  color("Gainsboro") translate([4, 1, 0]) cube([13, 15, 2]);
  // usb
  color("Gainsboro") translate([29, 0, 0 ]) cube([12, 17, 12]);

  // uart
  color("gray") translate([44, 17, 0 ]) cube([3, 11, 7]);

  // ethernet
  color("Gainsboro") translate([width-17, 8, 0]) cube([20, 16, 13]);

  // micro usb and button
  color("Gainsboro") translate([width-7, 28, -4]) cube([8, 7, 8]);

  // audio
  color("black") translate([width-11, 40, -6]) cube([13, 5, 11]);

  // sata
  color("gray") translate([26, height-6, 0]) cube([17, 6, 9]);

  // sata power
  color("white") translate([17, height-11, 0]) cube([7, 4, 7]);

  // ir
  color("black") translate([13, height-3, 2]) cube([4, 3, 5]);

  // power
  color("black") translate([0, height-9, 0]) cube([11, 7, 6]);

  // hdmi
  color("Gainsboro") translate([0, 20, 0]) cube([10, 14, 6]);

  // button power
  color("white") translate([0, 37, 0]) cube([3, 7, 4]);

  for(y=[1, height-6]) {
    color("gray") translate([44, y, -7]) cube([50, 5,8]);
  }

}

module cubieboard_screws(screw_radius) {
    color ("gray") for(x=[cubieboard_width-3 - 73.5, cubieboard_width-3]) for(y=[3, cubieboard_height-3]) {
        translate([x,y,-15]) cylinder(r=screw_radius, h=35);
    }
}

module cubieboard_glass(screw_radius) {
  offset = 0;
  depth=10;
  height=cubieboard_height;
  width=cubieboard_width;

  % translate([-offset, -offset, depth+5]) cube([width+offset*2, height+offset*2, 2]);


}

module cubieboard_wires() {

      // ethernet
    color("yellow") translate([cubieboard_width, 13, 5]) cube([50, 5, 5]);
    color("yellow") translate([cubieboard_width+50, 15.5, 0]) cube(size=[2,2,25], center=true);

    // power
    color("black") translate([-30, cubieboard_height-8, 1])  cube([30, 5, 5]);
    // color("black") translate([-30, cubieboard_height-5.5, -20]) cylinder(r=2, h=25);


}


module cubieboard_full(type, screw_radius) {
  if(type=="model") {
    cubieboard();
    cubieboard_glass(screw_radius);
    cubieboard_wires();
    cubieboard_screws(screw_radius);
  }

  if(type=="holes") {
    translate([cubieboard_width+50, 15.5, -15]) cube(size=[15, 25, 25], center=true);
    cubieboard_screws(screw_radius);
  }

  if(type=="footprint") {
    translate([0,0,-50]) cube([cubieboard_width, cubieboard_height, 100]);
  }

}

// cubieboard_full("footprint");
//cubieboard_full("model", 1.5);
// cubieboard_full("holes", 2);

