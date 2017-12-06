import processing.core.*;

// import java.io.*;
import java.math.BigDecimal;
import java.util.*;

Settings def = new Settings();
Impulsator impulse;



void setup(){
    //Setting Defaults

    
    
    frameRate(def.FRAMERATE);


    size(1000, 1000);
    background(def.BACKGROUND);
    impulse = new Impulsator(def, 0, 1, 1000, 20);
    

}

void draw(){
    clear();

    for(int x = 0; x < width - 100; x++){

        int y =  (int) ((x * x) * 0.001);
        stroke(def.PRIM);
        fill(def.PRIM);
        
        int xValue = x + mouseX;
        int yValue = y + mouseY;
        ellipse(xValue, yValue, 2, 2);
        
    }



    // clear();
    

    //     float y = sin(x) * 100 + 100;

    //     fill(def.PRIM);
    //     ellipse(x, (int)y, 1, 1);
    //     println(y);
    //     x++;

    

}


void clear(){
    background(def.BACKGROUND);
}

void mouseClicked(){
    impulse.direction *= -1;
}