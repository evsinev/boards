wandboard_width=95;
wandboard_height=95;

module wandboard_motherboard_bottom() {
  height = 95;
  width = 95;

  offset=3.5;
    
  difference() {
    color("green") translate([0, 0, -1]) cube([height, width, 1]);
    translate([offset, offset, -2]) cylinder(r=1.5, h=5);
    translate([height-offset, width-offset, -2]) cylinder(r=1.5, h=5);
    translate([height-offset, offset, -2]) cylinder(r=1.5, h=5);
    translate([offset, width-offset, -2]) cylinder(r=1.5, h=5);
    translate([width/2-offset, offset, -2]) cylinder(r=1.5, h=5);
  }
  
  // power
  color("black") translate([-1, 7, 0]) cube([13, 9, 10]);

  // ethernet
  color("Gainsboro") translate([-1, 40, 0]) cube([21, 15, 15]);

  // mini hdmi
  color("Gainsboro") translate([-1, 60, 0]) cube([10, 14, 5]);

  // optical
  color("black") translate([15, height+1-12, 0]) cube([8, 12, 11]);

  // audio
  for (x=[26, 37, 47]) {
    color("black") translate([x, height+2-18, 0]) cube([6, 18, 5]);
  }  

  // rs232
  color("SteelBlue") translate([55, height+5-10, 0]) cube([31, 10, 12]);

  // sata
  color("gray") translate([55, height-15, 0]) cube([17, 7, 9]);

  // usb
  color("Gainsboro") translate([width-15, 63, 0]) cube([15, 12, 7]);

  // micro sd
  color("Gainsboro") translate([width-13, 40, 0]) cube([13, 14, 1.5]);

  // micro usb
  color("Gainsboro") translate([width-8, 10, 0]) cube([8, 7, 4]);

}

module wandboard_motherboard_top() {
  for(x=[9, 27, 53, 72]) {
     color("black") translate([x, 3, 0]) cube([12.5, 3, 4.5]);
  }
  color("black") translate([5, 20, 0]) cube([84, 5, 7]);
  // button
  color("Gainsboro") translate([44, 9, 0]) cube([5, 5, 4]);
}

module wandboard_module() {
  width=82;
  height=60;

  color("DarkGreen") translate([0, 0, -1]) cube([width, height, 1]);

  // micro sd
  color("Gainsboro") translate([0, 20, 0]) cube([10, 10, 2]);

  // heat sink
  color("Gainsboro") {
    translate([0, 7, 2]) cube([width, height-7, 1.5]);
    for(y=[7 : 3 : height]) {
      translate([10, y, 3.5]) cube([width-20, 1, 5]);
    }
  }
  
  // screws
  color("gray") {
    translate([4, 10, -5]) cylinder(r=2.5, h=12);
    translate([width-4, 10, -5]) cylinder(r=2.5, h=12);
    translate([width-4, height-4, -5]) cylinder(r=2.5, h=12);
    translate([4, height-4, -5]) cylinder(r=2.5, h=12);
  }  
  
}

module wandboard_support() {
  height=95;
  width=95;
  support=30;
  level = 0 - support+5;
  offset=3.5;
  
  color("gray") {
    translate([offset, offset, level]) cube(size=[2, 2, support*2], center=true);
    translate([height-offset, width-offset, level]) cube(size=[2, 2, support*2], center=true);
    translate([height-offset, offset, level]) cube(size=[2, 2, support*2], center=true);
    translate([offset, width-offset, level]) cube(size=[2, 2, support*2], center=true);
  }  


}

module wandboard_screws(screw_radius) {
  offset=3.5;
  color("gray") for(x=[offset, wandboard_width-offset]) for(y=[offset, wandboard_height-offset]) {
    translate([x, y, -25]) cylinder(r=screw_radius, h=50);
  }
}

module wandboard_glass(screw_radius) {
  offset = 0;
  depth=10;
  height=wandboard_height;
  width=wandboard_width;

  % translate([-offset, -offset, depth+5]) cube([width+offset*2, height+offset*2, 2]);
}

module wandboard_wires() {
    off = 40;
    // ethernet
    color("yellow") translate([wandboard_width, 45, -10]) cube([off, 5, 5]);
    color("yellow") translate([wandboard_width+off, 47.5, -30]) cube(size=[4,4,25], center=true);

    // power
    color("black") translate([wandboard_width, 9, -10]) rotate([0,0,33]) cube([60, 5, 5]);
    color("black") translate([wandboard_width+off, 42.5, -30]) cube(size=[4,4,25], center=true);

}

module wandboard(type, screw_radius) {
  if(type=="model") {
    translate([95, 0, -1]) rotate([180, 0, 180]) wandboard_motherboard_bottom();
    wandboard_motherboard_top();
    translate([6, 22, 5]) wandboard_module();
    wandboard_support();
    wandboard_glass(screw_radius);
    wandboard_wires();
  }

  if(type=="holes") {
    // ethernet hole
    translate([wandboard_width+40, 47.5, -30]) cube(size=[15, 25, 25], center=true);
    // sata hole
    translate([30,wandboard_height-13, -30]) cube(size=[30, 15, 25], center=true);

    wandboard_screws(screw_radius);
  }

  if(type=="footprint") {
    translate([0,0,-50]) cube([wandboard_width, wandboard_height, 100]);
  }

}

// wandboard("footprint");
// wandboard("model", 1.5);
// wandboard("holes", 2);

