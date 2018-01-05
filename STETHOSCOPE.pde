import processing.core.*;

// import java.io.*;
import java.math.BigDecimal;
import java.util.*;

import ddf.minim.*;
import ddf.minim.analysis.*;
import javax.sound.sampled.*;



Settings def = new Settings(this);
STAudioInputController stethoscopeController;




boolean LOG = false;

int x;

int xStep = 5;



float min = 1;
float max = 0;
int res = 1;

void setup(){
    

    frameRate(def.FRAMERATE);
    size(1500, 1000);
    background(def.BACKGROUND);
    
    
    


    

    

    stethoscopeController = new STAudioInputController(def);


    

}

void draw(){

    
    float[] averages = stethoscopeController.getSampleAverages(res);
    for(float av: averages){
        println(av);
        if(av < min) min = av;
        if(av > max) max = av;
        
        
    }

    
    

}


void clear(){
    background(def.BACKGROUND);
}

void mouseClicked(){
    // impulse.direction *= -1;
    
    
    println("Resolution: " + res);
    println("Max: " + max);
    println("Min: " + min);
    println("\n");
    res *= 2;
    min = 1;
    max = 0;

}

void mouseMoved(){

}


void mousePressed(){

    stethoscopeController.stethoscope.getBufferPartial(0, 10);
}

void mouseReleased(){
    
}





