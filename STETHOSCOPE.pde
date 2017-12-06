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



    int y =  (int) ((x * x) * 0.001) + width/2;


    stroke(def.PRIM);
    fill(def.PRIM);
    ellipse(x, y, 2, 2);
    x++;

    // clear();
    // // for(int i = 0; i < width; i++){

    //     float y = sin(x) * 100 + 100;

    //     fill(def.PRIM);
    //     ellipse(x, (int)y, 1, 1);
    //     println(y);
    //     x++;

    // // }

}


void clear(){
    background(def.BACKGROUND);
}

void mouseClicked(){
    impulse.direction *= -1;
}