
// import java.math.BigDecimal;
// import java.io.*;
// import processing.core.*;




Settings def = new Settings(this);
Caleidoscope cali;
STAudioInputController stethoscope;
float radius;
float phi, theta;
float x, y, prev;
float z;

float xRotate, yRotate, zRotate;
float xTrans, yTrans;
int cross = 6000;
int _cross;
PVector center;
PVector eye;

float x2, y2;

float max, min;


int step = 30;

int rotationStep = 15;

char activeAxis;
// float cameraZOffset = 590;
float cameraZOffset = 0;

PImage crop;

void setup(){
    
    frameRate(def.FRAMERATE);
    // size(1000, 1000, P3D);
    fullScreen(P3D, 2);
    background(def.BACKGROUND);
    cali = new Caleidoscope(def);
    stethoscope = new STAudioInputController(def);

    hint(ENABLE_DEPTH_SORT);
    
    xRotate = yRotate = zRotate = xTrans = yTrans = 0;

    
    _cross = cross * -1;



    x = y = prev = 0;

    // stroke(255, 0, 0);
    // line(0, 200, width, 200);
    // line(0, 800, width, 800);

    max = 0;
    min = 1;

    crop = loadImage("CROP.png");
}

void draw(){

    pushMatrix();
    float strength = max(stethoscope.getAudioMappedTo(0, 1, 2));
    
    if(strength < min ) min = strength;
    if(strength > max) max = strength;

    background(def.BACKGROUND);
    
    
    setCamera(false);



    translate(width / 2, height / 2);

    cali.magic(0);


    strength = map(strength, min, max, 0, 1);
    if(strength > 0.2){
        strength = strength * 600 + 200;
        noFill();
        stroke(255);

        // line(x - 1, prev, x, strength);
        cali.pump = true;
        prev = strength;
        println("strength: "+strength);
    }



    x++;

    popMatrix();
    pushMatrix();
    translate(0, 0, 20);
    image(this.crop, 0, 0);
    popMatrix();

}

void drawTestLines(float xRotate, float yRotate, float zRotate){
    pushMatrix();
    rotateX(radians(xRotate));
    rotateY(radians(yRotate));
    rotateZ(radians(zRotate));
    translate(27, 27);


    
    dropDepthLines();
    popMatrix();
}

void setCamera(boolean useMouse){
    if(useMouse) cameraZOffset = map(mouseX, 0, width, -1000, 2000);
    eye = new PVector(width / 2, height / 2, (height/2.0) / tan(PI*30.0 / 180.0) + cameraZOffset);
    center = new PVector(width / 2, height / 2, 0);
    camera(
     eye.x,     //eye x
     eye.y,    //eye y
     eye.z,         //eyez
     center.x,     //center x
     center.y,    //center y
     center.z,             //center z
     0,             //up x
     1,             //up y
     0              //up z
     );
}


void mousePressed(){
    // println("theta = " + theta + ";");
    // println("phi = " + phi + ";");
    // println("xRotate = " + xRotate + ";");
    // println("yRotate = " + yRotate + ";");
    // println("zRotate = " + zRotate + ";");
    // println("xTrans = " + xTrans + ";");
    // println("yTrans = " + yTrans + ";");
    // println("x2 = " + x2 + ";");
    // println("y2 = " + y2 + ";");
    // println("cameraZOffset = " + cameraZOffset + ";");

    // println("\n");
    // cali.togglePlay();

    cali.pump = true;
    
    println("max: "+max);
    println("min: "+min);
    println("cameraZOffset: "+cameraZOffset);
    min = 1; 
    max = 0;
}   



void drop3DCross(){
    pushMatrix();
    // translate(500, 500, 0);
    strokeWeight(2);
    

    stroke(255, 0, 0);
    line(cross, 0, 0, _cross, 0, 0);


    stroke(0, 255, 0);
    line(0, cross, 0, 0, _cross, 0);

    stroke(0, 0, 255);
    line(0, 0, cross, 0, 0, _cross);

    translate(0, 0, 0);
    fill(255);
    noStroke();
    // lights();
    sphere(11);

    popMatrix();
}


PVector sphericalToCartesian(float radius, float theta, float phi){
    float x, y, z;
    z  = radius * sin(radians(phi)) * cos(radians(theta));
    x  = radius * sin(radians(phi)) * sin(radians(theta));
    y  = radius * cos(radians(phi));
    return new PVector(x, y, z);
}

void dropDepthLines(){
    int c, _c;
    c = 0;
    _c = _cross / 6;
    pushMatrix();
    stroke(255, 255, 0);
    strokeWeight(1);

    for(int x = 0; x <= 1000; x += step){
        for(int y = 0; y <= 1000; y += step){
            line(x, y, c, x, y, _c);
        }
        

    }
    popMatrix();
}


void keyPressed(){
    println(key + " " + keyCode);
    if(key == 'g'){
        if(rotationStep == 15) rotationStep = 1;
        else rotationStep = 15;
    }
    if(keyCode != 38 && keyCode != 40 && keyCode != 48){
        activeAxis = key;
    }


    if(keyCode == 38){
        if(activeAxis == 'x') xRotate += rotationStep;
        if(activeAxis == 'y') yRotate += rotationStep;
        if(activeAxis == 'z') zRotate += rotationStep;
        if(activeAxis == 'a') x2 += rotationStep;
        if(activeAxis == 'b') y2 += rotationStep;
    }else if(keyCode == 40){
        if(activeAxis == 'x') xRotate -= rotationStep;
        if(activeAxis == 'y') yRotate -= rotationStep;
        if(activeAxis == 'z') zRotate -= rotationStep;
        if(activeAxis == 'a') x2 -= rotationStep;
        if(activeAxis == 'b') y2 -= rotationStep;
    }else if(keyCode == 48){
        if(activeAxis == 'x') xRotate = 0;
        if(activeAxis == 'y') yRotate = 0;
        if(activeAxis == 'z') zRotate = 0;
        if(activeAxis == 'a') x2 = 0;
        if(activeAxis == 'b') y2 = 0;
        
    }
}





