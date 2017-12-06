import processing.core.*;

// import java.io.*;
import java.math.BigDecimal;
import java.util.*;

Settings def = new Settings();

SinePlotter sp;

int multiplicator = 1;

void setup(){
    //Setting Defaults

    
    
    frameRate(def.FRAMERATE);


    size(1500, 1000);
    background(def.BACKGROUND);
    sp = new SinePlotter(def, width, 1);
    sp.setOffsets(0, height / 2);
    

}

void draw(){
    clear();

    sp.plot();


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

void mouseMoved(){
    sp.amplifier = mouseY - 100;
}