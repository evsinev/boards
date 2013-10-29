module ssd() {
  width=100;
  height=69;

  difference() {
    color("Gainsboro") cube([width, height, 9]);
    color ("gray") for(x=[3, width-3]) for(y=[3, height-3]) {
      translate([x, y, -1]) cylinder(r=1.5, h=11);
    }  
  }
  color("black") translate([-1, 16, 0]) cube([1, 46, 6]);
  color("gray") translate([-2, 16, 0]) cube([1, 18, 6]);

  // screws
    color ("gray") for(x=[3, width-3]) for(y=[3, height-3]) {
      translate([x, y, -50]) cylinder(r=1.5, h=60);
    }  

  
}

// ssd();