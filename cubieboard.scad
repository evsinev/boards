cubieboard_width=100;
cubieboard_height=59;

module cubieboard() {
  width = 100;
  height = 59;
  // pcb
  difference() {
    color([0.1, 0.1, 0.1]) translate([0, 0, -1]) cube([width, height, 1]);
    color ("yellow") for(x=[22, width-3]) for(y=[3, height-3]) {
         translate([x,y,-2]) cylinder(r=1.5, h=3);
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

module cubieboard_glass() {
  offset = 10;
  depth=10;
  height=cubieboard_height;
  width=cubieboard_width;

  % translate([-offset, -offset, depth+5]) cube([width+offset*2, height+offset*2, 2]);

    color ("gray") for(x=[22, width-3]) for(y=[3, height-3]) {
         translate([x,y,-15]) cylinder(r=1.5, h=35);
    }

}

module cubieboard_wires_holes() {
    translate([cubieboard_width+50, 15.5, -15]) cylinder(r=7, h=25);
    translate([-30, cubieboard_height-5.5, -20]) cylinder(r=7, h=25);

}

module cubieboard_wires() {

      // ethernet
    color("yellow") translate([cubieboard_width, 13, 5]) cube([50, 5, 5]);
    color("yellow") translate([cubieboard_width+50, 15.5, -15]) cylinder(r=2, h=25);

    // power
    color("black") translate([-30, cubieboard_height-8, 1])  cube([30, 5, 5]);
    // color("black") translate([-30, cubieboard_height-5.5, -20]) cylinder(r=2, h=25);


}


module cubieboard_full() {
  cubieboard();
  cubieboard_glass();
  cubieboard_wires();
}

//cubieboard_full();
//cubieboard_wires_holes();
