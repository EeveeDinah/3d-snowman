sizeA = 20;
sizeC = 40;
smush = 0.8;

carrotW = 8;
carrotL = 16;

eyeSize = 3.5;
angleUp = 15;
angleOut = 25;

hatWidth = 24;
hatHeight = 28;
hatStripe = 6;

buttonAngle = 28;
buttonN = 4;
buttonSize = 0.3;

colourSnow = [0.9, 0.9, 0.9, 1];
colourCoal = [0.1, 0.1, 0.1, 1];
colourCarrot = [0.9, 0.5, 0.1, 1];
colourHat = [0.2, 0.2, 0.2, 1];
colourStripe = [0.1, 0.1, 0.4, 1];
colourButton = [0.9, 0.1, 0.1, 1];

// End of variables

sizeB = (sizeC+sizeA)/2;

module button(size){

    // Variables
    buttonH = 1;
    buttonR = 7;
    trim = 2;
    holeR = 1;
    holeD = 3.5;
    holeN = 4;

    // Button
    rotate([0,90,0]){
        scale(size, size, size){
            difference(){
                union(){
                    // Body
                    cylinder(buttonH, buttonR, buttonR);

                    // Edge
                    translate([0,0,-(trim-buttonH)/2]){
                        difference(){
                            cylinder(trim, buttonR + trim, buttonR + trim, $fn=50);
                            translate([0,0,-0.5]){
                                cylinder(trim+1, buttonR, buttonR, $fn=50);
                            }
                        }
                    }
                }

                // Holes
                union(){
                    translate([0, 0, -(buttonH)/2]){
                        for(i = [1:holeN]){
                            angle = 360 * (i / holeN);
                            translate([sin(angle)*holeD, cos(angle)*holeD, 0]){
                                cylinder(buttonH+1, holeR, holeR, $fn=20);  
                            }
                        }
                        
                    }
                }
            }
        }
    }
}

// Snowman
translate([0,0,sizeC]){

    // Base
    translate([0, 0, 0]){

        // Base Sphere    
        color(colourSnow){
            sphere(sizeC, $fn=80);
        }
    }

    // Body
    translate([0,0,(sizeC+sizeB)*smush]){

        // Body Sphere
        color(colourSnow){
            sphere(sizeB, $fn=80);
        }

        // Buttons
        color(colourButton){
            for(i = [1:buttonN]){
                angleDown = buttonAngle * 2 * ((i - 1) / (buttonN-1)) + 90 - buttonAngle;
                echo(angleDown);

                translate([sizeB*sin(angleDown), 0, sizeB*cos(angleDown)]){
                    rotate([0, angleDown - 90, 0]){
                        button(buttonSize);
                    }
                }
            }
        }
    }

    // Head
    translate([0,0,((sizeC+sizeB*2+sizeA)*smush)]){
        
        // Head sphere
        color(colourSnow){
            sphere(sizeA, $fn=80);
        }

        // Carrot
        color(colourCarrot){
            translate([sizeA * 0.95,0,0]){
                rotate([0,90,0]){
                    rotate_extrude(angle = 360, convexity = 2) {
                        polygon(points = [[0,0],[carrotW/2,0],[0,carrotL]]);
                    }
                }
            }
        }

        // Hat
        translate([0, 0, sizeA*0.7]){
            color(colourHat){
                cylinder(sizeA/10, hatWidth, hatWidth);
                cylinder(hatHeight, sizeA*0.7, sizeA*0.7);
            }
            color(colourStripe){
                cylinder(hatStripe, sizeA*0.75, sizeA*0.75);
            }
        }

        // Eyes
        color(colourCoal){
            translate([(sizeA*sin(90-angleUp)*cos(angleOut)), (sizeA*sin(90-angleUp)*sin(angleOut)), sizeA*cos(90-angleUp)]){
                rotate(rands(0,360,3)){
                    sphere(eyeSize, $fn=7);
                }
            }
            translate([(sizeA*sin(90-angleUp)*cos(angleOut)), (sizeA*sin(90-angleUp)*sin(-angleOut)), sizeA*cos(90-angleUp)]){
                rotate(rands(0,360,3)){
                    sphere(eyeSize, $fn=7);
                }
            }
        }
    }
}