screwR = 1.3;
screwHeadR = 2.5;
w = 4;
cameraR = 9;
axleR = 3;
eyeD = 60;
$fn = 100;
bearingIR = 8/2;
bearingOR = 22.4/2;
bearingW = 7;
servoGearR = 2.5;
servoGearH = 3;
servoX = 12.3;
servoY = 22.6;
servoArmW = 32.3;
servoArmH = 11;

module shape(n, outterRadius) {
    or = outterRadius;
    d = 360 / n;
    points = [ for (i = [1 : n]) [or * cos(i*d), or * sin(i*d)] ];
    polygon(points);
}

module m3nut() {
    linear_extrude(height=3)
        shape(6, 4);
}

module embiggen() {
    minkowski() {
        children(0);
        sphere(0.2);
    }
}

module servoArm(){
    linear_extrude(height=5){
        circle(d=7);
        translate([0,14]) circle(d=4);
        polygon([[3,0], [2,14], [-2,14], [-3,0]]);
    }
}
    
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
                cylinder(h=400,r=8,center=true);
        translate([22,8,123]) sphere(40.2);

    }
}

module fingers() {
    boxHeight = 80;
    difference() {
        hand();
        translate([0,0,boxHeight/2]) cube([100,130,boxHeight], center=true);
    }
}


module palm() {
    boxHeight = 80;
    intersection() {
        hand();
        translate([0,0,boxHeight/2]) cube([100,130,boxHeight], center=true);
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
        // space for the cord
        translate([0,-8,-50]) cylinder(h=30, r=3);
    }
}

module wristAxel2() {
    
}

module wristAxel1() {
    difference() {
        union() {
            translate([0,0,0]) cylinder(r=bearingIR+2, h=10);
            translate([0,0,0]) cylinder(r=bearingIR, h=bearingW+10+2);
            translate([0,0,bearingW+10+2+4]) cube([4,7,8], center=true);
        }
        
        embiggen() servoArm();
    }
}

module wristAxel2() {
    difference() {
        translate([0,0,5]) cube([9.4,9.4,10], center=true);
        translate([0,0,5]) embiggen() cube([4, 7, 10], center=true);
    }
}

module wristAxel() {
    difference() {
        translate([0,0,10]) {
            union() {
                translate([0,0,6]) cube([9.4,9.4,8], center=true);
                translate([0,0,-10]) cylinder(r=bearingIR, h=12);
                translate([0,0,0]) cylinder(r=bearingIR+1, h=2);
            }
            union() {
                translate([0,0,-10]) cylinder(h=servoGearH, r=servoGearR);
                translate([0,0,-10]) cylinder(h=20, r=screwR);
                translate([0,0,-6]) cylinder(h=16, r=screwHeadR);
            }
        }
        servoArm();
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

//fingers();
//wristAxel2();
wristAxel1();