

difference(){
	translate(v = [0, 0, -125.0000000000]) {
		intersection() {
			intersection() {
				difference() {
					difference() {
						difference() {
							difference() {
								intersection() {
									intersection() {
										translate(v = [-40, 18, 0]) {
											import(file = "D:/Projects/HandEyeCoordination/models/V3/hand_v2.stl", origin = [0, 0]);
										}
										translate(v = [-65.0000000000, -75.0000000000, 0]) {
											cube(size = [130, 150, 500]);
										}
									}
									translate(v = [-65.0000000000, -75.0000000000, 0]) {
										cube(size = [130, 150, 250.0000000000]);
									}
								}
								scale(v = 0.9000000000) {
									intersection() {
										intersection() {
											translate(v = [-40, 18, 0]) {
												import(file = "D:/Projects/HandEyeCoordination/models/V3/hand_v2.stl", origin = [0, 0]);
											}
											translate(v = [-65.0000000000, -75.0000000000, 0]) {
												cube(size = [130, 150, 500]);
											}
										}
										translate(v = [-65.0000000000, -75.0000000000, 0]) {
											cube(size = [130, 150, 250.0000000000]);
										}
									}
								}
							}
							translate(v = [0, 0, 222.0000000000]) {
								scale(v = [1, 1, 4]) {
									union() {
										cylinder(h = 7, r = 11.2000000000);
									}
								}
							}
						}
						translate(v = [0, 0, 233.0000000000]) {
							cylinder(h = 10, r = 15);
						}
					}
					translate(v = [0, 0, 204.0000000000]) {
						union() {
							translate(v = [-6.1500000000, -6.1500000000, 0]) {
								cube(size = [12.3000000000, 22.8000000000, 29.8000000000]);
							}
							translate(v = [-6.1500000000, -10.9000000000, 0]) {
								cube(size = [12.3000000000, 32.3000000000, 21.8000000000]);
							}
						}
					}
				}
				translate(v = [-65.0000000000, -75.0000000000, 0]) {
					cube(size = [130, 150, 250.0000000000]);
				}
			}
			translate(v = [-65.0000000000, -75.0000000000, 125.0000000000]) {
				cube(size = [130, 150, 125.0000000000]);
			}
		}
	}
	/* Holes Below*/
	translate(v = [0, 0, -125.0000000000]){
		intersection(){
			intersection(){
				difference(){
					difference(){
						difference(){
							translate(v = [0, 0, 222.0000000000]){
								scale(v = [1, 1, 4]){
									union(){
										cylinder(h = 7, r = 4);
									}
								}
							}
						}
					}
				}
			}
		}
	} /* End Holes */ 
}