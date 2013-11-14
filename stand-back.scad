back_width=450;
back_height=450;

back_thick = 4;
back_depth = 60;

support_size = back_depth;

module draw_walls(back, left_right, top_bottom) {
  // back
 if(back==true) {
  difference() {
    cube([back_width, back_height, back_thick]);
    back_holes();
  }
 }

  // left and right
 if(left_right==true) {
  for(x=[0, back_width-back_thick]) {  
    translate([x,0, back_thick]) cube([back_thick, back_height, back_depth]);
  }
 }

  // bottom and top
 if(top_bottom==true) {
  for(y=[0, back_height-back_thick]) {  
    translate([back_thick, y, back_thick]) cube([back_width-back_thick*2, back_thick, back_depth]);
  }
 }
  // front
}

module back_holes2() {
  off = support_size / 3;
  translate([off, off, -50]) cylinder(r=2.5, h=150);
  translate([off+off, off*2, -50]) cylinder(r=2.5, h=150);

  rotate([90,0,0]) {
    translate([off+off/2, off, -70]) cylinder(r=2.5, h=150);
    translate([off+off/2, 2*off, -70]) cylinder(r=2.5, h=150);
  }

  rotate([0,90,0]) {
    translate([off+off/2-support_size, off, -50]) cylinder(r=2.5, h=150);
    translate([off+off/2-support_size, 2*off, -50]) cylinder(r=2.5, h=150);
  }
}

module light_cube() {

    for(x=[10 : 10 : 50]) {
       for(y=[10:10:50] ) {
         translate([x, y,-20]) cylinder(r=3, h=90);
       }
    }

 
}

module back_support() {
  t = 2;
  s = support_size-t*2;
  color("red") difference() {
    cube([support_size-10, support_size, support_size]);
    light_cube();
    rotate([0,90,0]) translate([-60,0, 0]) light_cube();
    rotate([90,90,0]) translate([-60,0, -60]) light_cube();
    translate([t, t, t]) 
         cube([s+10, s, s]);
    back_holes2();
  }

  

}

module back_supports() {
  translate([back_thick, back_thick, back_thick]) back_support(add_y=10);
  translate([back_thick, back_height-support_size-back_thick, back_thick]) back_support();

  translate([back_width-back_thick, support_size+back_thick, back_thick]) rotate([0, 0,180 ]) back_support();
  translate([back_width-back_thick, back_height-back_thick, back_thick]) rotate([0, 0,180 ]) back_support();
}

module back_all(back, left_right, top_bottom) {

  draw_walls(back, left_right, top_bottom);
  back_supports();

}

module back_with_holes(back, left_right, top_bottom) {

  difference() {
    draw_walls(back, left_right, top_bottom);
    back_supports();
  }

}


module back_holes() {
  for(x=[100 : 50 : 350]) {
    for(y=[100 : 50 : 350]) {
      translate([x, y, -40]) cube([25, 15,100]);
    }
  }
}

module back_projections() {
  back_with_holes(true);
  translate([back_width,-0.1 + back_thick, 0]) rotate([90,270,0]) back_with_holes(false, true, false, $fn=25);
  translate([0,-0.1-back_depth+back_thick,-back_thick]) rotate([90,0,0]) back_with_holes(false, false, true);

}
// color("lightgray") back_all(true, true, true);

// projection(cut = true) 
//  back_projections();

// back_supports();
rotate([0, 270, 0]) back_support();
translate([65, 0, 0]) rotate([0, 270, 0]) back_support();
translate([65, 65, 0]) rotate([0, 270, 0]) back_support();
translate([0, -5, 0]) cube([70, 135, 0.25]);
translate([-65, -5, 0]) cube([125, 70, 0.25]);
