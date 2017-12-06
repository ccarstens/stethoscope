import processing.core.*;

// import java.io.*;
import java.math.BigDecimal;
import java.util.*;

Settings def = new Settings();
Impulsator impulse;

int multiplicator = 1;

void setup(){
    //Setting Defaults

    
    
    frameRate(def.FRAMERATE);


    size(1000, 1000);
    background(def.BACKGROUND);
    impulse = new Impulsator(def, 0, 1, 1000, 20);
    

}

void draw(){
    clear();

    for(int x = 0; x < width; x++){

        // float t = (int)((float)x / (float)width * PI * 30);
        // println(t);
        float y =  sin(((float)x / (float)width * multiplicator * PI * 2)) * mouseY;
        // println(y);
        stroke(def.PRIM);
        fill(def.PRIM);
        
        int xValue = x + 0;
        int yValue = (int)y + width / 2;
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
    // impulse.direction *= -1;
    multiplicator += 1;
    println(multiplicator);
}