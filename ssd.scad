ssd_width = 100;
ssd_height = 70;

module ssd_screws(screw_radius) {
  // screws
    color ("gray") for(x=[13, 13+76.5]) for(y=[4, 4+61.5]) {
      translate([x, y, -50]) cylinder(r=screw_radius, h=60);
    }  
}

module ssd_model() {
  width=ssd_width;
  height=ssd_height;

  difference() {
    color("Gainsboro") cube([width, height, 9]);
    ssd_screws(1.5);
  }
  color("black") translate([-1, 16, 0]) cube([1, 46, 6]);
  color("gray") translate([-2, 16, 0]) cube([1, 18, 6]);


  
}

module ssd(type, screw_radius) {
  if(type=="model") {
    ssd_model();
    ssd_screws(screw_radius);
  }

  if(type=="holes") {
    ssd_screws(screw_radius);
  }

  if(type=="footprint") {
    translate([0,0, -50]) cube([ssd_width, ssd_height, 100]);
  }

}

// ssd("model", 1.5);
// ssd("footprint", 1.5);
// ssd("holes", 2);
