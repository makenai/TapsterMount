beam_unit = 8;
base_width = 88; // 11 units
base_height = 153; // 19 units

corner_radius = 5;

phone_thickness = 5;
tab_thickness = 1;
tab_diameter = 10;
phone_width = 64;
phone_height = 130;


combined_thickness = phone_thickness + tab_thickness;
brick_size = beam_unit * 4;

peg_height = 5;
peg_diameter = 5;

module peg() {
	offset = beam_unit/2;
	translate([offset,offset,combined_thickness])
		cylinder(d=peg_diameter,h=peg_height);
}

module block() {
	x_phone_offset = base_width/2-phone_width/2;
	y_phone_offset = base_height/2-phone_height/2;
	union() {
		difference() {
			cube(size=[brick_size,brick_size,combined_thickness]);
			translate([x_phone_offset,y_phone_offset,-1])
				cube(size=[phone_width,phone_height,combined_thickness+2]);
			translate([0,0,-1])
				edge();
			translate([0,0,1])
				edge();
		}
		translate([x_phone_offset,y_phone_offset,0]) {
			edge();
			cylinder(d=tab_diameter,h=tab_thickness);
		}
		
		for ( i = [1:3] ) {
			translate([i*8,0,0])
				peg();
			translate([0,i*8,0])
				peg();
		}
	}
}

module edge() {
	difference() {
		cube(size=[corner_radius/2,corner_radius/2,combined_thickness]);
		translate([corner_radius/2,corner_radius/2,-1])
			cylinder(d=corner_radius,h=combined_thickness+2);
	}
	
}

block();