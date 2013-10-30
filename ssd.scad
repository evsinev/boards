ssd_width = 100;
ssd_height = 69;

module ssd_screws(screw_radius) {
  // screws
    color ("gray") for(x=[3, ssd_width-3]) for(y=[3, ssd_height-3]) {
      translate([x, y, -50]) cylinder(r=screw_radius, h=60);
    }  
}

module ssd_model() {
  width=ssd_width;
  height=ssd_height;

  difference() {
    color("Gainsboro") cube([width, height, 9]);
    color ("gray") for(x=[3, width-3]) for(y=[3, height-3]) {
      translate([x, y, -1]) cylinder(r=1.5, h=11);
    }  
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
