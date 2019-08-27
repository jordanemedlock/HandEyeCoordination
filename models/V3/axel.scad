

difference() {
	union() {
		union() {
			cylinder(h = 8, r = 10);
			cylinder(h = 10, r = 6);
		}
		cylinder(h = 60, r = 4);
	}
	linear_extrude(height = 5) {
		union() {
			circle(d = 7);
			translate(v = [0, 14]) {
				circle(d = 4);
			}
			polygon(paths = [[0, 1, 2, 3]], points = [[3, 0], [2, 14], [-2, 14], [-3, 0]]);
		}
	}
}