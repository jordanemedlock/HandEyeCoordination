

difference(){
	rotate(a = [0, 0, 90]) {
		intersection() {
			difference() {
				difference() {
					difference() {
						union() {
							difference() {
								intersection() {
									difference() {
										sphere($fn = 100, r = 45);
										sphere($fn = 100, r = 41);
									}
									translate(v = [-50, -50, -20]) {
										cube(size = [100, 100, 100]);
									}
								}
								cylinder(h = 100, r = 9);
							}
							translate(v = [0, 0, 34]) {
								union() {
									union() {
										union() {
											union() {
												translate(v = [14, 14, 0]) {
													difference() {
														cylinder(h = 10, r = 3);
														cylinder(h = 10, r = 1);
													}
												}
												translate(v = [14, -14, 0]) {
													difference() {
														cylinder(h = 10, r = 3);
														cylinder(h = 10, r = 1);
													}
												}
											}
											translate(v = [-14, 14, 0]) {
												difference() {
													cylinder(h = 10, r = 3);
													cylinder(h = 10, r = 1);
												}
											}
										}
										translate(v = [-14, -14, 0]) {
											difference() {
												cylinder(h = 10, r = 3);
												cylinder(h = 10, r = 1);
											}
										}
									}
									difference() {
										cylinder(h = 20, r = 40);
										translate(v = [-15, -15, 0]) {
											cube(size = [30, 30, 20]);
										}
									}
								}
							}
						}
						translate(v = [45, 0, 0]) {
							rotate(a = [0, 90, 0]) {
								translate(v = [-6.1500000000, -6.1500000000, -28.8000000000]) {
									union() {
										cube(size = [12.3000000000, 22.8000000000, 22.8000000000]);
										scale(v = [1, -1, 1]) {
											translate(v = [0, 0, 0]) {
												union() {
													cube(size = [12.3000000000, 4.7500000000, 20.8000000000]);
													translate(v = [6.1500000000, 2, 0]) {
														cylinder(h = 32.8000000000, r = 1);
													}
												}
											}
										}
										translate(v = [0, 22.8000000000, 0]) {
											union() {
												cube(size = [12.3000000000, 4.7500000000, 20.8000000000]);
												translate(v = [6.1500000000, 2, 0]) {
													cylinder(h = 32.8000000000, r = 1);
												}
											}
										}
										translate(v = [6.1500000000, 6.1500000000, 0]) {
											union() {
												cylinder(h = 28.8000000000, r = 6.1500000000);
												translate(v = [0, 7.1500000000, 0]) {
													cylinder(h = 28.8000000000, r = 2.5000000000);
												}
											}
										}
									}
								}
							}
						}
					}
					translate(v = [-43, 0, 0]) {
						rotate(a = [0, 90, 0]) {
							union() {
								cylinder(h = 7, r = 11.2000000000);
							}
						}
					}
				}
				translate(v = [-42, 0, 0]) {
					rotate(a = [0, 90, 0]) {
						cylinder(center = true, h = 20, r = 5);
					}
				}
			}
			sphere($fn = 100, r = 45);
		}
	}
	/* Holes Below*/
	rotate(a = [0, 0, 90]){
		intersection(){
			difference(){
				difference(){
					translate(v = [-43, 0, 0]){
						rotate(a = [0, 90, 0]){
							union(){
								cylinder(h = 7, r = 4);
							}
						}
					}
				}
			}
		}
	} /* End Holes */ 
}