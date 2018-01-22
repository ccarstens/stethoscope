
// import java.math.BigDecimal;
// import java.io.*;
// import processing.core.*;




Settings def = new Settings(this);
Caleidoscope cali;


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

    PVector center = new PVector(width/2.0, height/2.0, 0);
    
    // PVector eye = new PVector(500, 500, ((height/2.0) / tan(PI*30.0 / 180.0)));

    float radius = (height/2.0) / tan(PI*30.0 / 180.0);
    float theta = 0;
    float x = radius * sin(radians(theta));
    float z = radius * cos(radians(theta));

    PVector eye = new PVector(x, 500, z);
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
    // rotateX(radians(map(mouseX, 0, width, -180, 180)));
    pushMatrix();
    translate(0, 0, center.z);
    ellipse(center.x, center.y, 40, 40);
    popMatrix();
    // cali.magic();
    
    

}

void mousePressed(){
    println("eye xy " + map(mouseY, 0, height, -500, height * 2));
    println(" eye z " + (((height/2.0) / tan(PI*30.0 / 180.0)) - map(mouseX, 0, width, - 500, 2000)));
}



