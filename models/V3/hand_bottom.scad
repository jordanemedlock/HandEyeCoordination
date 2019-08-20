

intersection() {
	intersection() {
		difference() {
			difference() {
				difference() {
					translate(v = [0, 0, -250.0000000000]) {
						intersection() {
							intersection() {
								translate(v = [-40, 18, 0]) {
									import(file = "D:/Projects/HandEyeCoordination/models/V3/hand_v2.stl", origin = [0, 0]);
								}
								translate(v = [-65.0000000000, -75.0000000000, 0]) {
									cube(size = [130, 150, 500]);
								}
							}
							translate(v = [-65.0000000000, -75.0000000000, 250.0000000000]) {
								cube(size = [130, 150, 250.0000000000]);
							}
						}
					}
					translate(v = [25, 7, 173]) {
						sphere($fn = 100, r = 50);
					}
				}
				union() {
					union() {
						cylinder(h = 13, r = 4.5000000000);
						translate(v = [0, 0, 6.5000000000]) {
							cube(center = true, size = [4, 30, 13]);
						}
					}
					translate(v = [0, 0, 6.5000000000]) {
						cube(center = true, size = [30, 4, 13]);
					}
				}
			}
			translate(v = [0, 0, 130]) {
				rotate(a = [0, -90, 0]) {
					cylinder(h = 60, r = 8);
				}
			}
		}
		translate(v = [-65.0000000000, -75.0000000000, 0]) {
			cube(size = [130, 150, 250.0000000000]);
		}
	}
	translate(v = [-65.0000000000, -75.0000000000, 0]) {
		cube(size = [130, 150, 125.0000000000]);
	}
}