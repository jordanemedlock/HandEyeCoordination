screwR = 1.1;
screwHeadR = 2.5;
w = 4;
cameraR = 9;
axleR = 3;
eyeD = 60;
$fn = 100;
bearingIR = 7.6/2;
bearingOR = 22.4/2;
bearingW = 7;
servoGearR = 2.5;
servoGearH = 3;
servoX = 12.3;
servoY = 22.6;
servoArmW = 32.3;
servoArmH = 11;


    
module arm() {
    translate([5,0,-170]) 
        scale(290) 
            import("hand_v2.stl", convexity = 5);
}

module hand() {
    difference() {
        arm();
        // cutting forearm off
        translate([-60,-50,-300]) cube([120,100,300]);
        // twisting peg
        translate([0,0,5]) cube([10.4,10.4,10.4], center=true);
        
        // cord hole
        rotate(a=[0,45,0])
            translate([-70,15,100]) 
                cylinder(h=400,r=7,center=true);
        translate([22,8,123]) sphere(40.2);

    }
}

module servoNeg() {
    union() {
        armInset = servoArmH + 10;
        armOffset = -(servoX+1)/2 - (servoArmW-servoY)/2;
        // slice down the middle
        translate([-(servoX+1)/2,-(servoX+1)/2,-101]) 
            cube([servoX+1, servoY+1, 102]);
        // servo arms
        translate([-(servoX+1)/2,armOffset,-armInset]) cube([servoX+1, servoArmW+1, armInset]);
        // bearing hole
        translate([0,0,-bearingW]) cylinder(h=bearingW+0.2, r=bearingOR);
        // extra stuff for bearing
        translate([0,0,-10]) cylinder(h=10+0.1, r=9);
    }
}

module wristAxel() {
    difference() {
        union() {
            translate([0,0,6]) cube([10,10,8], center=true);
            translate([0,0,-10]) cylinder(r=bearingIR, h=12);
            translate([0,0,0]) cylinder(r=bearingIR+1, h=2);
        }
        translate([0,0,-10]) cylinder(h=servoGearH, r=servoGearR);
        translate([0,0,-10]) cylinder(h=20, r=screwR);
        translate([0,0,0]) cylinder(h=10, r=screwHeadR);
    }
}

module forearm() {
        difference() {
            arm();
            // cut at top and bottom
            translate([-60,-50,0]) cube([120,120,300]);
            translate([-60,-50,-300]) cube([120,120,200]);
            // remove the servo bit
            servoNeg();
            // remove the chunk at the bottom
            translate([-25,(servoX+1)/2-1.5,-100+(servoX+1)/2]) cube([50, servoY+1, servoX+1], center=true);
        }
}

module eyeGimbal() {
    union() {
        eyeFrame();
        eye();
    }
}

module eyeFrame() {
    union() {
        intersection() {
            difference() {
                sphere(40);
                sphere(36);
                rotate(a=[90,0,0]) cylinder(r=5.2,h=80,center=true);

            }
            
            translate([0,0,-5]) cube([80,80,20], center=true);
        }
        gimbalAxis();
    }
}

module eye() {
    intersection() {
        difference() {
            sphere(35);
            sphere(31);
            cylinder(r=cameraR, h=35);
            rotate(a=[90,0,0]) cylinder(r=5.2,h=80,center=true);

        }
        translate([0,0,12.5]) cube([70,70,55], center=true);
    }
    
}

module handEyeCoordination() {
    %hand();
    %translate([22,8,123]) rotate(a=[0,70,-15]) eyeGimbal();
    wristAxel();
    !forearm();
}

module gimbalAxis() {
    translate([0,-25,0]) {
        rotate([90,0,0]) {
            difference() {
                cylinder(r=5, h=15);
                cylinder(r=screwR, h=15);
                cylinder(r=servoGearR, h=servoGearH);
                translate([0,0,11]) cylinder(r=screwHeadR, h=4);
            }
        }
    }

    translate([0,30,0]) {
        rotate([-90, 0, 0]) {
            cylinder(r=5, h=10);
        }
    }

}

//handEyeCoordination();

forearm();
