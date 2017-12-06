import processing.core.*;

// import java.io.*;
import java.math.BigDecimal;
import java.util.*;

import ddf.minim.*;
import ddf.minim.analysis.*;
import javax.sound.sampled.*;



Settings def = new Settings();

SinePlotter sp;
SineImpulse si;

Minim globalMinim;
STAudioInput stethoscope;

BeatDetect beat;



void setup(){
    

    frameRate(def.FRAMERATE);
    size(1500, 1000);
    background(def.BACKGROUND);
    sp = new SinePlotter(def, width);
    sp.setOffsets(0, height / 2);
    si = new SineImpulse(def, 5, 100);


    globalMinim = new Minim(this);
    stethoscope = new STAudioInput(def, globalMinim, "Soundflower (2ch)");

    beat = new BeatDetect();


    

}

void draw(){
    // clear();

    
    // sp.amplifier = (int)si.read();

    
    background(0);
    beat.detect(stethoscope.in.mix);
    if ( beat.isOnset() ) sp.amplifier = 500;
    sp.amplifier *= 0.9;

    sp.plot();
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








