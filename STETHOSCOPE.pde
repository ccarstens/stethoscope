
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
    
    println((height/2.0) / tan(PI*30.0 / 180.0));
}

void draw(){

    camera(
     width / 4,     //eye x
     height / 4,    //eye y
     map(mouseX, 0, width, -500, 3000),   //eyez
     width/2.0,     //center x
     height/2.0,    //center y
     0,             //center z
     0,             //up x
     1,             //up y
     0              //up z
     );
    cali.magic();
    
    

}

void mousePressed(){
    println("eye z " + map(mouseX, 0, width, -500, 3000));
}



