import processing.core.*;

// import java.io.*;
import java.math.BigDecimal;
import java.util.*;

import ddf.minim.*;
import javax.sound.sampled.*;



Settings def = new Settings();

SinePlotter sp;
SineImpulse si;

Minim globalMinim;
STAudioInput stethoscope;



void setup(){
    

    frameRate(def.FRAMERATE);
    size(1500, 1000);
    background(def.BACKGROUND);
    sp = new SinePlotter(def, width);
    sp.setOffsets(0, height / 2);
    si = new SineImpulse(def, 5, 100);


    globalMinim = new Minim(this);
    stethoscope = new STAudioInput(def, globalMinim, "Soundflower (2ch)");


    

}

void draw(){
    clear();

    sp.plot();
    sp.amplifier = (int)si.read();
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

    println(si.resolution);
}