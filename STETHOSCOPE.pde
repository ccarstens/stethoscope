
// import java.math.BigDecimal;
// import java.io.*;
// import processing.core.*;




Settings def = new Settings(this);
STAudioInputController stethoscopeController;




boolean LOG = false;

int x = 0;

int xStep = 2;



float min = 1;
float max = 0;
int res = 2;

float lastY = 0;

void setup(){
    

    frameRate(def.FRAMERATE);
    size(1500, 1000);
    background(def.BACKGROUND);
    
    
    


    

    

    stethoscopeController = new STAudioInputController(def);


    

}

void draw(){

    
    float[] mappedAverages = stethoscopeController.getAudioMappedTo(800, res);
    for(float av: mappedAverages){
        // println(av);
        // if(av < min) min = av;
        // if(av > max) max = av;
        
        stroke(255);
        strokeWeight(2);
        line(x - xStep, lastY, x, av);
        fill(255, 0, 0);
        noStroke();
        ellipse(x, av, 6, 6);
        lastY = av;
        x += xStep;
        
        
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





