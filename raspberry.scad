raspberry_width = 85;
raspberry_height = 56;

module raspberry() {
  
  width = 85;
  height = 56;
  
  	color("green") translate([0,0,-1.4]) cube([width, height,1.4]);

   // hdmi
   color("Gainsboro") translate([33, 0, 0]) cube([14, 11, 5]);

   // fd1
   color("Gainsboro") translate([57, 0, 0]) cube([3, 23, 5]);

   // ethernet
   difference() {
     color("Gainsboro") translate([width+1-20, 2, 0]) cube([20, 16, 13]);
     color([0.2, 0.2, 0.2]) translate([width-10, 4, 2]) cube([12, 12, 7]);
   }

   // usb
   difference() {
     color("Gainsboro") translate([width-10, 25, 0]) cube([17, 12, 15]);
     for(z=[1, 9]) {
       color("white") translate([width, 26, z]) cube([10, 10, 5]);
     }
   }

   // audio
   color("black") translate([58, height-10, 0]) cube([12, 10, 10]);
   color("black") translate([64, height+3.5, 4]) rotate([90, 0, 0]) cylinder(r=3.5, h=3.5);

   // p2
   color("black") translate([52, 27, 0]) cube([2, 19, 9]);

   // video
   color("yello") translate([40.5, height-12, 0]) cube([10, 10, 12]);
   color("Gainsboro") translate([45.5, height+7, 7]) rotate([90, 0, 0]) cylinder(r=4, h=10);

   // p1
   color("black") translate([1, height-6, 0]) cube([32, 5, 9]);

   color("Gainsboro") translate([11, 12, 0]) cube([2, 22, 5]);

   // micro usb
   difference() {
     color("Gainsboro") translate([-0.5, 4, 0]) cube([6, 8, 3]);
     color("Gainsboro") translate([-1  , 5, 1]) cube([3, 6, 1]);
   }

   // sd card
   color("gray") translate([1, 15, -4.5]) cube([16, 29, 3.5]);

   // sd card
   color("blue") translate([-16 , 17, -4]) cube([31, 24, 2]);

}

module smart_reader() {
   color([0.15, 0.15, 0.15]) {
     translate([0, 0, 0]) cube([32, 19, 7.5]);
     difference() {
       translate([5, -20, -2]) cube([20, 56, 13]);
       translate([4, -19, -1]) cube([22, 54, 11]);
     }

   }
   // usb
   color("gray") translate([-12  , 3, 3]) cube([12, 11, 4]);

   // card 
   color("white") translate([2  , -19, 0]) cube([85, 54, 1]);



}

module raspberry_support() {
  w = 10;
  h = 2;
  depth=15;

  level = 10;
  
  // pcb
  difference() {
    cube([w, h, depth]);
    translate([-1, -1, level]) cube([6, h+2, 1.5]);
  }

  // screw  hole
  difference() {
    translate([0, 0, 0]) cube([w, 10, 4]);
    translate([5, 6, -1]) cylinder(r=2, h=6);
  }

  // screw 
  translate([5, 6, -6]) cylinder(r=1.5, h=12);
  

}

module raspberry_supports() {
  // top left
  translate([5, 47, -11.4]) rotate([0,0,180]) raspberry_support();

  // bottom center
  translate([53, 5, -11.4]) rotate([0,0,270]) raspberry_support();
  // translate([53, 0, 0]) cube([2, 5, 5]);
  
  // center right
  translate([85-5, 20, -11.4]) rotate([0,0,0]) raspberry_support();
  //translate([85-5, 20, 0]) cube([5, 2, 5]);

  // top center 
  translate([39, 56-5, -11.4]) rotate([0,0,90]) raspberry_support();
  translate([37, 56-5, 0]) cube([2, 5, 5]);

}

module raspberry_glass() {
  offset = 10;
  % translate([-offset,-offset,16]) cube([85+offset*2, 56+offset*2, 2]);
  
  color("gray") for(x=[offset/-2, 85+offset/2]) for(y=[-offset/2, 56+offset/2])  {
    translate([x, y, -17]) cylinder(r=1.5, h=40);
  }
  
}

module raspberry_wires_holes() {
    translate([raspberry_width+50, 9.5, -23]) cylinder(r=7, h=30);
    translate([-30, 8, -15]) cylinder(r=7, h=20);
}

module raspberry_wires() {
  // ethernet
  color("yellow") {
    translate([raspberry_width, 7, 2]) cube([50, 5, 5]);
    translate([raspberry_width+50, 9.5, -23]) cylinder(r=2, h=30);
  }

  color("black") {
    translate([-30, 5, 0]) cube([30, 5, 5]);
    //translate([-30, 8, -15]) cylinder(r=2, h=20);
  }
}

module raspberry_hsm() {
  raspberry();
  translate([96, 22.5, 7]) smart_reader();

  color("white") raspberry_supports();
  raspberry_glass();
  raspberry_wires();
}



//raspberry_hsm();
//raspberry_wires_holes();
