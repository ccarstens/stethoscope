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
    // if(!def.TESTING){
    //     // clear();

        
    //     // sp.amplifier = (int)si.read();
        
    //     background(0);
    //     beat.detect(stethoscope.in.mix);
    //     if ( beat.isOnset() ) sp.amplifier = 500;
    //     sp.amplifier *= 0.9;

    //     sp.plot();
    // }else{
    //     //TESTING

    //     if(DRAW){
    //         fill(255);
    //         // background(0);
    //         stroke(255);

    //         // println("S");
    //         // println(stethoscope.in.bufferSize());
    //         //the buffer size is set to sample rate by frame rate, so that all the samples that will be played during one frame are in the buffer at the same time
    //         //then all the sample values are being added up and devided by the bufferSize, resulting in the average sample value
    //         // all negative sample values are being multiplied with -1 so they turn positive and added
    //         // the resulting average sample of one frame is then used to calculate the y value for the graphs points
    //         for(int i = 0; i < stethoscope.in.bufferSize() - 1; i++){
    //             float curr = stethoscope.in.left.get(i);
    //             if(curr > 0) curr *= -1;
    //             sum += curr;

    //             // line( i, 500 + stethoscope.in.left.get(i)*1000, i+1, 500 + stethoscope.in.left.get(i+1)*1000 );
            
    //         }
    //         log("sum" + sum);
    //         log("");
    //         newValue = sum /stethoscope.in.bufferSize();
    //         newValue = 500 + newValue * 1000;
    //         log("new value: " + newValue);

    //         line(x - xStep, oldValue, x, newValue);
    //         // ellipse(x, newValue, 2, 2);
    //         log(sum / stethoscope.in.bufferSize());
    //         oldValue = newValue;
    //         sum = 0;
    //         x += xStep;
    //         if(x > width){
    //             clear();
    //             x = 0;
    //         }

    //     }






    // }

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



