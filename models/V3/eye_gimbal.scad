

rotate(a = [0, 0, 180]) {
	difference() {
		difference() {
			intersection() {
				difference() {
					sphere($fn = 100, r = 50);
					sphere($fn = 100, r = 46);
				}
				translate(v = [-50, -50, -10]) {
					cube(size = [100, 100, 30]);
				}
			}
			translate(v = [0, 45, 0]) {
				rotate(a = [0, -90, 90]) {
					translate(v = [0, 0, -5]) {
						union() {
							translate(v = [0, 0, -1]) {
								linear_extrude(height = 3) {
									union() {
										circle(d = 7);
										translate(v = [0, 14]) {
											circle(d = 4);
										}
										polygon(paths = [[0, 1, 2, 3]], points = [[3, 0], [2, 14], [-2, 14], [-3, 0]]);
									}
								}
							}
							cylinder(d = 7, h = 6);
						}
					}
				}
			}
		}
		translate(v = [0, -50, 0]) {
			rotate(a = [0, 90, 90]) {
				union() {
					cylinder(h = 10, r = 4);
					translate(v = [-4.3000000000, -8.3000000000, 0]) {
						cube(size = [8.6000000000, 16.6000000000, 6]);
					}
				}
			}
		}
	}
}