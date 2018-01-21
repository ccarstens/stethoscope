
// import java.math.BigDecimal;
// import java.io.*;
// import processing.core.*;




Settings def = new Settings(this);
Caleidoscope cali;


void setup(){
    

    frameRate(def.FRAMERATE);
    size(1500, 1000);
    background(def.BACKGROUND);
    cali = new Caleidoscope(def);
    

}

void draw(){

    
    cali.magic();
    
    

}



