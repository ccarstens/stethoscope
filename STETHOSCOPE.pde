
// import java.math.BigDecimal;
// import java.io.*;
// import processing.core.*;




Settings def = new Settings(this);
Caleidoscope cali;
float radius;
float theta;
float x;
float z;

int cross = 1000;

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

    PVector center = new PVector(0, 0, 0);
    
    // PVector eye = new PVector(500, 500, ((height/2.0) / tan(PI*30.0 / 180.0)));

    radius = (height/2.0) / tan(PI*30.0 / 180.0);
    theta = 0;
    x = radius * sin(radians(theta));
    z = radius * cos(radians(theta));


    PVector eye = new PVector(0, 0, (height/2.0) / tan(PI*30.0 / 180.0));
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
    // rotateX(radians(map(mouseX, 0, width, -180, 180)));
    pushMatrix();
    translate(0, 0, center.z);
    ellipse(center.x, center.y, 2, 2);
    popMatrix();
    // cali.magic();
    
    

}

void mousePressed(){
    println("x: " + x + " \nz: " + z);
}


void drop3DCross(){
    strokeWeight(4);
    int _cross = cross * -1;
    stroke(255, 0, 0);
    line(0, 0, cross, 0, 0, _cross);

    stroke(0, 255, 0);
    line(0, cross, 0, 0, _cross, 0);

    stroke(0, 0, 255);
    line(cross, 0, 0, _cross, 0, 0);
}



