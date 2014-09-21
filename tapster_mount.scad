beam_unit = 8;s
base_width = 88; // 11 units
base_height = 153; // 19 units

phone_thickness = 5;
phone_width = 64;
phone_height = 130;


brick_size = beam_unit * 4;

peg_height = 5;
peg_diameter = 5;

module peg() {
	offset = beam_unit/2;
	translate([offset,offset,phone_thickness])
		cylinder(d=peg_diameter,h=peg_height);
}

module block() {
	union() {
		difference() {
			cube(size=[brick_size,brick_size,phone_thickness]);
			translate([base_width/2-phone_width/2,base_height/2-phone_height/2,-1])
				cube(size=[phone_width,phone_height,phone_thickness+2]);
		}
		for ( i = [1:3] ) {
			translate([i*8,0,0])
				peg();
			translate([0,i*8,0])
				peg();
		}
	}
}

block();