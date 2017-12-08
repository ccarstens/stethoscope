import processing.core.*;

// import java.io.*;
import java.math.BigDecimal;
import java.util.*;

import ddf.minim.*;
import ddf.minim.analysis.*;
import javax.sound.sampled.*;



Settings def = new Settings(this);

SinePlotter sp;
SineImpulse si;

Minim globalMinim;

BeatDetect beat;

boolean DRAW = false;
float sum;
float oldValue;
float newValue;

boolean LOG = false;

int x;

int xStep = 5;

STAudioInputController stethoscopeController;

void setup(){
    

    frameRate(def.FRAMERATE);
    size(1500, 1000);
    background(def.BACKGROUND);
    sp = new SinePlotter(def, width);
    sp.setOffsets(0, height / 2);
    si = new SineImpulse(def, 5, 100);


    globalMinim = new Minim(this);

    beat = new BeatDetect();

    stethoscopeController = new STAudioInputController(def);


    

}

void draw(){

    if(DRAW){
        stethoscopeController.calculateBufferPartialAverage(100);
    }
    

}


void clear(){
    background(def.BACKGROUND);
}

void mouseClicked(){
    // impulse.direction *= -1;
    sp.waveCount++;
}

void mouseMoved(){
    si.amplifier = mouseY;
    si.resolution = (int)((float)mouseX / (float)width * 300);

}


void mousePressed(){
    DRAW = true;
    stethoscopeController.stethoscope.getBufferPartial(0, 10);
}

void mouseReleased(){
    DRAW = false;
}


void log(String message){
    if(LOG){
        println(message);
    }
}



