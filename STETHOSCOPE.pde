import processing.core.*;

// import java.io.*;
import java.math.BigDecimal;
import java.util.*;

Settings def = new Settings();
Impulsator impulse;

int x = 0;

void setup(){
    //Setting Defaults

    
    
    frameRate(def.FRAMERATE);


    size(1000, 1000);
    background(def.BACKGROUND);
    impulse = new Impulsator(def, 0, 1, 1000, 20);
    

}

void draw(){
    // clear();
    for(int i = 0; i < 4; i++){
        BigDecimal h = new BigDecimal(height);
        // int y = impulse.readSine(100, 200);
        int y = (int) ((sin(x) * 30) + 200);
        println(y);
        fill(def.PRIM);
        ellipse(x, y, 5, 5);
        x++;
        if(x > width){
            x = 0;
        }
    }

}


void clear(){
    background(def.BACKGROUND);
}

void mouseClicked(){
    impulse.direction *= -1;
}