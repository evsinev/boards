include <odroid.scad>
include <wandboard.scad>
include <../xz0032/case/base2.scad>
include <cubieboard.scad>
include <raspberry.scad>
include <ssd.scad>
include <stand-back.scad>

lcd_w=91;
lcd_h=53;

draw_label=1;

lcd_level=-3.5;

stand_width=450;
stand_height=450;

nginx_x = 175;
nginx_y = 100;

nginx_proc_x = nginx_x+54;
nginx_proc_y = nginx_y+8;

proc_x = nginx_proc_x+lcd_w+3;
proc_y = nginx_y+15;

hsm_x = proc_x-60;
hsm_y = proc_y-145;

ui_x = nginx_x;
ui_y = nginx_y+189;

nginx_ui_x = nginx_x + 63;
nginx_ui_y = nginx_y + 95;

ui_db_x = ui_x+54;
ui_db_y = ui_y+6;

proc_db_x=proc_x+73;
proc_db_y=proc_y+54;

proc_hsm_x = proc_db_x;
proc_hsm_y = proc_y-94;


internet_nginx_x=nginx_x-94;
internet_nginx_y=nginx_proc_y;

db_x = nginx_ui_x+89;
db_y = ui_y-26;

ssd_x = db_x+118;
ssd_y = db_y +31;

sso_ui_x = ui_x - 94;
sso_ui_y = ui_db_y;

sso_x = sso_ui_x+5;
sso_y = ui_y+odroid_height;


thick=4;

module draw_servers(type, screw_radius) {

   
    // nginx
  translate([nginx_x, nginx_y+cubieboard_width, thick+10]) rotate([0, 0, 270]) cubieboard_full(type, screw_radius); 
  
  // proc
  translate([proc_x, proc_y, thick+1]) rotate([0,0, 0]) odroid_full(type, screw_radius, "center");
  
  // nginx -> proc
  translate([nginx_proc_x, nginx_proc_y, lcd_level]) lcd1(type, screw_radius);  
 
  // ui
  translate([ui_x+odroid_width, ui_y+odroid_height, thick+1]) rotate([0,0, 180]) odroid_full(type, screw_radius);

  // nginx -> ui
  translate([nginx_ui_x, nginx_ui_y, lcd_level]) rotate([0,0, 90]) lcd1(type, screw_radius);  
  
  // ui -> db
  translate([ui_db_x, ui_db_y, lcd_level]) rotate([0,0, 0]) lcd1(type, screw_radius);  

  // db
  translate([db_x+wandboard_width, db_y, thick+20]) rotate([0, 0, 90]) wandboard(type, screw_radius); 

  // ssd
  translate([ssd_x-ssd_width, ssd_y+ssd_height, thick+1])  rotate([0, 0, 270]) ssd(type, screw_radius);

  // proc -> db
  translate([proc_db_x, proc_db_y, lcd_level]) rotate([0,0,90]) lcd1(type, screw_radius);  

  // internet -> nginx
  translate([internet_nginx_x, internet_nginx_y, lcd_level]) lcd1(type, screw_radius);  

  // sso
  translate([sso_x, sso_y, thick+1])  rotate([0,0,180]) odroid_full(type, screw_radius, "no", -40);

  // sso -> ui
  translate([sso_ui_x, sso_ui_y, lcd_level]) rotate([0,0, 0]) lcd1(type, screw_radius);  
  
   // smart reader
  translate([proc_x+57, proc_y-5, 40]) rotate([0,180,90]) smart_reader(type, screw_radius);


}

module glass() {
    cube([stand_width, stand_height, thick]);
}

module lcd1(type, screw_radius) {
  // translate([0, 90, 0])  rotate([180, 0, 0]) all();
  // lcd_pcb();
  translate([0, 0, -2]) xz0032_base2(type, screw_radius);
}

module label() {
  difference() {
    color("LightBlue") translate([0, 0, thick]) cube([stand_width, stand_height, 1]);
    draw_servers("holes", 2);
  }
}

module lcd_holes() {
  translate([outer_width+9, -5.5, 5-2]) rotate([0, 180, 0])  xz0032_screws(2);
}



module glass_with_holes() {
  difference() {
    glass();
    draw_servers("holes", 2);
  }

}

module label_with_holes() {
  if(draw_label==1) {
    difference() {
      translate([0, 0, 0]) label();
      draw_servers("holes", 2);
    // nginx -> proc
    translate([nginx_proc_x+5, nginx_proc_y+14,  -thick]) cube([89, 32, 13]);

    // nginx -> ui
    translate([nginx_ui_x-50, nginx_ui_y+5,  -2]) cube([32, 90, 8]);
    // ui -> db
    translate([ui_x+58, ui_y+20,  -2]) cube([90, 32, 8]);
    // internet -> nginx
    translate([internet_nginx_x+6, nginx_proc_y+14,  -2]) cube([88, 32, 8]);

    // proc - > db
    translate([proc_hsm_x-50, proc_db_y+5,  -2]) cube([32, 89, 8]);

    // ui -> sso
    translate([sso_x, ui_y+20,  -2]) cube([89, 32, 8]);

    stand_screws();
    }
  }
  
}


module stand_screws() {
  offset=15;
  for(x=[offset, stand_width-offset]) for(y=[offset, stand_height-offset]) {
    translate([x, y, -20]) cylinder(r=2, h=40);
  }
}

module back_positioned() {
  translate([0,0, -back_depth-thick]) back_all(true, true, true);
}

module stand_full() {

  % glass_with_holes();
  draw_servers("model", 1.5);
  label_with_holes();
  translate([proc_x+57, proc_y-5, 40]) rotate([0,180,90]) smart_reader();
  
  back_positioned();
  stand_screws();
}

module footprints() {
  difference() {
    glass();
    draw_servers("footprint", 1.5);
  }
  // translate([0,0, 60])  draw_servers("footprint", 1.5);
}


// stand_full();

//projection(cut = false) 
//  footprints();

projection(cut = false) 
 label_with_holes();

// projection(cut = false)  
// glass_with_holes($fn=50);

