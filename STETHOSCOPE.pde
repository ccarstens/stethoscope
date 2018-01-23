
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

int cross = 6000;
int _cross;
PVector center;
PVector eye;

ArrayList<Mover> movers;
Iterator<Mover> it;

int step = 30;

char activeAxis;

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
    
    xRotate = yRotate = zRotate = 0;

    movers = new ArrayList<Mover>();
    _cross = cross * -1;

    
}

void draw(){
    background(def.BACKGROUND);
    
    center = new PVector(0, 0, 0);
    
    // PVector eye = new PVector(500, 500, ((height/2.0) / tan(PI*30.0 / 180.0)));

    radius = (height/2.0) / tan(PI*30.0 / 180.0) + 300;
    theta = map(mouseX, 0, width, -180, 180);
    phi = map(mouseY, 0, height, -90, 270);

    // theta = -21.23999;
    // phi = 109.07999;
    // xRotate = -3.0;
    // yRotate = 0.0;
    // zRotate = 3.0;

    theta = 0;
    phi = 90;
    // xRotate = 0.0;
    // yRotate = 0.0;
    // zRotate = 0.0;
    
    eye = sphericalToCartesian(radius, theta, phi);
    
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
    // translate(map(mouseX, 0, width, 1000, -1000), map(mouseY, 0, height, 1000, -1000));
    // pushMatrix();
    yRotate = map(mouseX, 0, width, 90, -90);
    xRotate = map(mouseY, 0, height, -90, 90);
    rotateX(radians(xRotate));
    rotate(radians(zRotate));
    rotateY(radians(yRotate));
    
    drop3DCross();
    dropDepthLines();
    rectMode(CENTER);
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
    c = cross / 9;
    _c = _cross / 6;
    pushMatrix();
    stroke(255, 255, 0);
    strokeWeight(1);

    for(int x = -500; x <= 500; x += step){
        for(int y = -500; y <= 500; y += step){
            line(x, y, c, x, y, _c);
        }
        

    }
    popMatrix();
}


void keyPressed(){
    println(key + " " + keyCode);
    if(keyCode != 38 && keyCode != 40 && keyCode != 48){
        activeAxis = key;
    }

    if(keyCode == 38){
        if(activeAxis == 'x') xRotate += 1;
        if(activeAxis == 'y') yRotate += 1;
        if(activeAxis == 'z') zRotate += 1;
    }else if(keyCode == 40){
        if(activeAxis == 'x') xRotate -= 1;
        if(activeAxis == 'y') yRotate -= 1;
        if(activeAxis == 'z') zRotate -= 1;
    }else if(keyCode == 48){
        if(activeAxis == 'x') xRotate = 0;
        if(activeAxis == 'y') yRotate = 0;
        if(activeAxis == 'z') zRotate = 0;
        
    }
}


