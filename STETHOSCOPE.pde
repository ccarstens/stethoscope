
// import java.math.BigDecimal;
// import java.io.*;
// import processing.core.*;




Settings def = new Settings(this);
Caleidoscope cali;
float radius;
float phi, theta;
float x;
float z;

int cross = 1000;

PVector center;
PVector eye;

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
    
    
}

void draw(){
    background(def.BACKGROUND);

    center = new PVector(0, 0, 0);
    
    // PVector eye = new PVector(500, 500, ((height/2.0) / tan(PI*30.0 / 180.0)));

    radius = (height/2.0) / tan(PI*30.0 / 180.0);
    phi = map(mouseX, 0, width, -180, 180);



    eye = sphericalToCartesian(radius, 0, phi);
    println(eye.x + " " + eye.y + " " + eye.z);
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
    drop3DCross();
    
    translate(0, 0, 0);
    rectMode(CENTER);
    noFill();
    stroke(0, 255, 255);
    rect(0, 0, 1000, 1000);

    // cali.magic();
    
    

}

void mousePressed(){
    
}


void drop3DCross(){
    strokeWeight(2);
    int _cross = cross * -1;

    stroke(255, 0, 0);
    line(cross, 0, 0, _cross, 0, 0);


    stroke(0, 255, 0);
    line(0, cross, 0, 0, _cross, 0);

    stroke(0, 0, 255);
    line(0, 0, cross, 0, 0, _cross);

    translate(center.x, center.y, center.z);
    fill(255);
    noStroke();
    lights();
    sphere(11);
}


PVector sphericalToCartesian(float radius, float theta, float phi){
    float x, y, z;
    x = radius * sin(radians(phi)) * cos(radians(theta));
    y = radius * sin(radians(phi)) * sin(radians(theta));
    z = radius * cos(radians(phi));
    return new PVector(x, y, z);
}



