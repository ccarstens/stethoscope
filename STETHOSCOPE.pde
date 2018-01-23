
// import java.math.BigDecimal;
// import java.io.*;
// import processing.core.*;




Settings def = new Settings(this);
Caleidoscope cali;
float radius;
float phi, theta;
float x;
float z;

float xRotate, yRotate, zRotate;
float xTrans, yTrans;
int cross = 6000;
int _cross;
PVector center;
PVector eye;

float x2, y2;

ArrayList<Mover> movers;
Iterator<Mover> it;

int step = 30;

int rotationStep = 15;

char activeAxis;
float cameraZOffset;
void setup(){
    

    frameRate(def.FRAMERATE);
    size(1000, 1000, P3D);
    background(def.BACKGROUND);
    cali = new Caleidoscope(def);

    hint(ENABLE_DEPTH_SORT);

    
    // camera(
    //  width/2.0,     //eye x
    //  height/2.0,    //eye y
    //  (height/2.0) / tan(PI*30.0 / 180.0),   //eyez
    //  width/2.0,     //center x
    //  height/2.0,    //center y
    //  0,             //center z
    //  0,             //up x
    //  1,             //up y
    //  0              //up z
    //  );

    // camera(
    //  0,     //eye x
    //  0,    //eye y
    //  (height/2.0) / tan(PI*30.0 / 180.0),   //eyez
    //  0,     //center x
    //  0,    //center y
    //  0,             //center z
    //  0,             //up x
    //  1,             //up y
    //  0              //up z
    //  );
    
    xRotate = yRotate = zRotate = xTrans = yTrans = 0;

    movers = new ArrayList<Mover>();
    _cross = cross * -1;

    
}

void draw(){
    background(def.BACKGROUND);
    
    center = new PVector(width / 2, height / 2, 0);
    
    // PVector eye = new PVector(500, 500, ((height/2.0) / tan(PI*30.0 / 180.0)));
    cameraZOffset = map(mouseX, 0, width, 0, 2000);
    radius = (height/2.0) / tan(PI*30.0 / 180.0) + 121;
    theta = map(mouseX, 0, width, -180, 180);
    phi = map(mouseY, 0, height, -90, 270);

    // yRotate = map(mouseX, 0, width, 90, -90);
    // xRotate = map(mouseY, 0, height, -90, 90);
    // theta = -21.23999;
    // phi = 109.07999;
    // xRotate = -3.0;
    // yRotate = 0.0;
    // zRotate = 3.0;

    theta = 0.0;
    phi = 90.0;
    // xRotate = -18.0;
    // yRotate = 0.0;
    // zRotate = -135.0;
    cameraZOffset = 590.0;
    // eye = sphericalToCartesian(radius, theta, phi);

    eye = new PVector(width / 2, height / 2, (height/2.0) / tan(PI*30.0 / 180.0) + cameraZOffset);
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
    // pushMatrix();
    xTrans = map(mouseX, 0, width, 1000, -1000);
    yTrans = map(mouseY, 0, height, 1000, -1000);
    xTrans = 500.0;
    yTrans = 500.0;
    
    // pushMatrix();
    translate(xTrans, yTrans);
    rotateX(radians(xRotate));
    rotateY(radians(yRotate));
    rotateZ(radians(zRotate));


    translate(x2, y2);

    drop3DCross();
    dropDepthLines();
    // rectMode(CENTER);
    noFill();
    stroke(0, 255, 255);
    rect(0, 0, 1000, 1000);

    // popMatrix();
    // popMatrix();

    // movers.add(new Mover(def));

    // Iterator<Mover> it = movers.iterator();
    // while(it.hasNext()){
    //     Mover m = it.next();
    //     m.run();
    //     if(m.isDead()){
    //         it.remove();
    //     }
    // }
    

}

void mousePressed(){
    println("theta = " + theta + ";");
    println("phi = " + phi + ";");
    println("xRotate = " + xRotate + ";");
    println("yRotate = " + yRotate + ";");
    println("zRotate = " + zRotate + ";");
    println("xTrans = " + xTrans + ";");
    println("yTrans = " + yTrans + ";");
    println("x2 = " + x2 + ";");
    println("y2 = " + y2 + ";");
    println("cameraZOffset = " + cameraZOffset + ";");
    println("Movers Count: " + movers.size());
    println("\n");
    
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




// Quadrant 0

// theta = 0.0;
// phi = 90.0;
// xRotate = -18.0;
// yRotate = 0.0;
// zRotate = -135.0;
// xTrans = 500.0;
// yTrans = 500.0;
// x2 = 27.0;
// y2 = 27.0;
// cameraZOffset = 590.0;



// Quadrant 1
// theta = 0.0;
// phi = 90.0;
// xRotate = 0.0;
// yRotate = -18.0;
// zRotate = -45.0;
// xTrans = 500.0;
// yTrans = 500.0;
// x2 = 27.0;
// y2 = 27.0;
// cameraZOffset = 590.0;


// Quadrant 2
// theta = 0.0;
// phi = 90.0;
// xRotate = 18.0;
// yRotate = 0.0;
// zRotate = 45.0;
// xTrans = 500.0;
// yTrans = 500.0;
// x2 = 27.0;
// y2 = 27.0;
// cameraZOffset = 590.0;



// Quadrant 3
// theta = 0.0;
// phi = 90.0;
// xRotate = 0.0;
// yRotate = 18.0;
// zRotate = 135.0;
// xTrans = 500.0;
// yTrans = 500.0;
// x2 = 27.0;
// y2 = 27.0;
// cameraZOffset = 590.0;

