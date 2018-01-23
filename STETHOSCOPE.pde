
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
    
    theta = 0;
    phi = 90;
}

void draw(){
    background(def.BACKGROUND);
    drop3DCross();
    center = new PVector(0, 0, 0);
    
    // PVector eye = new PVector(500, 500, ((height/2.0) / tan(PI*30.0 / 180.0)));

    radius = (height/2.0) / tan(PI*30.0 / 180.0) + 300;
    // theta = map(mouseX, 0, width, -180, 180);
    // phi = map(mouseY, 0, height, -90, 270);

    
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
    
    
    translate(0, 0, 0);
    rectMode(CENTER);
    noFill();
    stroke(0, 255, 255);
    rect(0, 0, 1000, 1000);

    // cali.magic();
    
    theta -= 1;
    phi += 1;

}

void mousePressed(){
    println("THETA " + theta);
    println("PHI: " + phi);
    println("\n");
    
}


void drop3DCross(){
    pushMatrix();
    // translate(500, 500, 0);
    strokeWeight(2);
    int _cross = cross * -1;

    stroke(255, 0, 0);
    line(cross, 0, 0, _cross, 0, 0);


    stroke(0, 255, 0);
    line(0, cross, 0, 0, _cross, 0);

    stroke(0, 0, 255);
    line(0, 0, cross, 0, 0, _cross);

    translate(0, 0, 0);
    fill(255);
    noStroke();
    lights();
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



