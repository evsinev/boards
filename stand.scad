include <odroid.scad>
include <wandboard.scad>
include <../xz0032/case/case.scad>
include <cubieboard.scad>
include <raspberry.scad>
include <ssd.scad>

lcd_w=91;
lcd_h=53;

lcd_level=-3.5;

stand_width=800;
stand_height=600;

nginx_x = 62*4;
nginx_y = 55*4;

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

db_x = nginx_ui_x+85;
db_y = ui_y-26;

ssd_x = db_x+150;
ssd_y = db_y + 10;

sso_ui_x = ui_x - 94;
sso_ui_y = ui_db_y;

sso_x = sso_ui_x+5;
sso_y = ui_y+odroid_height;



thick=4;

module glass() {
    cube([stand_width, stand_height, thick]);
}

module lcd1() {
  // translate([0, 90, 0])  rotate([180, 0, 0]) all();
  lcd_pcb();
}

module label() {
  difference() {
    color("LightBlue") translate([0, 0, thick]) cube([stand_width, stand_height, 1]);
    // nginx -> ui
    translate([nginx_proc_x, nginx_proc_y+14,  -thick]) cube([94, 32, 13]);
    // ui -> sso
    translate([proc_hsm_x+18, proc_hsm_y-100,  -2]) cube([32, 94, 8]);
    // nginx -> ui
    translate([nginx_ui_x-57, nginx_ui_y+5,  -2]) cube([32, 94, 8]);
    // proc -> hsm
    translate([ui_x+58, ui_y+20,  -2]) cube([94, 32, 8]);
    // internet -> nginx
    translate([internet_nginx_x+6, internet_nginx_y+13,  -2]) cube([94, 32, 8]);

    // ui - > db
    //translate([proc_db_x+6, proc_db_y+13,  -2]) cube([94, 32, 8]);

  }
}


module holes() {
  //translate([100, 100, thick+1]) odroid_wires_holes();
  // translate([200, 100, thick]) odroid_wires_holes();

  //translate([300, 100, thick]) odroid_wires_holes();

  //translate([50, 200, thick+20])  wandboard_wires_holes();

  //translate([50, 350, thick+12]) raspberry_wires_holes(); 

  // translate([50, 450, thick+10]) cubieboard_wires_holes(); 

}

module glass_and_label_with_holes() {
  % difference() {
    glass();
    holes();
  }

  //difference() {
  //  translate([0, 0, 600*$t]) label();
  //  holes();
  //}

  
}

module stand_old() {

translate([200, 100, thick]) odroid_full();

translate([300, 100, thick]) odroid_full();

translate([50, 200, thick+20])  wandboard();

translate([250, 230, thick])  ssd();

color("black") translate([200, 240, 10]) cube([50, 5, 5]);

translate([250, 350, 0]) lcd1();

translate([50, 350, thick+12]) raspberry_hsm(); 


}



module stand_full() {
  glass_and_label_with_holes();

  // nginx
  translate([nginx_x, nginx_y+cubieboard_width, thick+10]) rotate([0, 0, 270]) cubieboard_full(); 
  
  // proc
  translate([proc_x+odroid_width+1, proc_y, thick+2]) rotate([0,0, 90]) odroid_full();
  
  // nginx -> proc
  translate([nginx_proc_x, nginx_proc_y, lcd_level]) lcd1();  

  // proc -> hsm
  translate([proc_hsm_x, proc_hsm_y, lcd_level]) rotate([0,0, 90]) lcd1();  

  // hsm
  translate([hsm_x+odroid_width, hsm_y, thick+2]) rotate([0,0, 0]) raspberry_hsm();
  
  // ui
  translate([ui_x+odroid_width, ui_y+odroid_height, thick+2]) rotate([0,0, 180]) odroid_full();

  // nginx -> ui
  translate([nginx_ui_x, nginx_ui_y, lcd_level]) rotate([0,0, 90]) lcd1();  
  
  // ui -> db
  translate([ui_db_x, ui_db_y, lcd_level]) rotate([0,0, 0]) lcd1();  

  // db
  translate([db_x, db_y, thick+20]) wandboard(); 

  // ssd
  translate([ssd_x, ssd_y, thick+30])  ssd();

  // proc -> db
  translate([proc_db_x, proc_db_y, lcd_level]) rotate([0,0,90]) lcd1();  

  // internet -> nginx
  translate([internet_nginx_x, internet_nginx_y, lcd_level]) lcd1();  

  // sso
  translate([sso_x, sso_y, thick+12])  rotate([0,0,180]) odroid_full();

  // sso -> ui
  translate([sso_ui_x, sso_ui_y, lcd_level]) rotate([0,0, 0]) lcd1();  


}

stand_full();

