screwR = 1.1;
screwHeadR = 2.5;
w = 4;
cameraR = 9;
axleR = 3;
eyeD = 60;
cutHD = 10;
cutHU = 5;
socketM = 1;
fn = 100;
bearingIR = 7.6/2;
bearingOR = 22.4/2;
bearingW = 7;
servoGearR = 2.5;
servoGearH = 3;


module shell(innerR, outterR) {
    difference(){
        sphere(outterR, $fn=fn);
        sphere(innerR, $fn=fn);
    }
}

module cutOffEdge(radius, distance, direction) {
    
    d = radius - distance;
    c = direction * (radius + distance) / 2;
    translate([0,0,c]) {
        cube([radius*2, radius*2, d],
            center=true);
    }
}

module eye(outterD) {
    outterR = outterD / 2;
    innerR = outterR - w;
    
    difference(){
        shell(innerR, outterR);
    
        cutOffEdge(outterR, cutHD, -1);
        
        cylinder(r=cameraR, h=outterR, $fn=fn);
        
        rotate(a=[0,90,0]) {
            cylinder(r=axleR, h=outterR*2, 
                center=true, $fn=fn);
        }
    }
}

module socket() {
    ir = eyeD / 2 + socketM;
    or = ir + w;
    
    difference() {
        shell(ir, or);
        
        cutOffEdge(or, cutHD, -1);
        
        cutOffEdge(or, cutHU, +1);
        
        rotate(a=[0,90,0]) {
            cylinder(r=axleR, h=or*2, 
                center=true, $fn=fn);
        }
    }
}

module gimbal() {
    ir = eyeD / 2 + socketM;
    rotate([-90, 0, 0]) {
        translate([0, 0, -ir]) {
            difference() {
                union() {
                    translate([0, 0, ir]) {
                        rotate([90, 0, 0]) {
                            socket();
                        }
                    }
                    
                    gimbalPost();
                }
                translate([0,0,-w]){
                    cylinder(r=screwHeadR, 
                    h=w+2+bearingW+2-servoGearH-3, $fn=fn);
                }
            }
        }
    }
}

module gimbalPost() {
    // body of the thing
    rotate([180, 0, 0]) {
        difference(){
            union() {
                cylinder(r=bearingIR+1.5, 
                    h=w+2, $fn=fn);
                translate([0,0,w+2]) {
                    cylinder(r=bearingIR, 
                        h=bearingW+2, $fn=fn);
                }
            }
            
            // screw hole
            translate([0,0,-1]) {
                cylinder(r=screwHeadR, 
                    h=w+2+bearingW+2-servoGearH-3, $fn=fn);
            }
            cylinder(r=screwR, 
                h=w+2+bearingW+2, $fn=fn);
            translate([0,0,w+2+bearingW+2-servoGearH]) {
                cylinder(r=servoGearR, 
                    h=servoGearH+1, $fn=fn);
            }
        }
    }
}

module bearingMount() {
    difference() {
        union() {
            cube([60, 12, bearingW+7], 
                center=true);
            cylinder(r=bearingOR+w, h=bearingW+7, 
                center=true, $fn=fn);
        }
        cylinder(r=bearingOR, h=bearingW+7+1,
            center=true, $fn=fn);
    }
}

//eye(eyeD);
//gimbal();
bearingMount();

