class Caleidoscope extends SettingsReceiver {

    boolean mirror = false;
    
    int x;
    int y;
    int z;


    int y3dCurrent = 0;

    Caleidoscope(Settings def){
        super(def);
    }


    public void magic(){
        background(this.def.BACKGROUND);
        pushMatrix();
        this.runQuadrant(0);
        this.runQuadrant(1);
        this.runQuadrant(2);
        this.runQuadrant(3);



        popMatrix();

        this.y3dCurrent += 1;
    }


    public void _draw(){
        
        // this.xy(mouseX, mouseY);
        stroke(this.def.PRIM);
        fill(this.def.PRIM);
        this.y3d(mouseY);
        pushMatrix();
        translate(this.x, this.y);
        ellipse(0, 0, 50, 50);

        popMatrix();

        if(this.def.SHOWLINES){
            line(0, 0, 0, 1000);
            line(0, 0, 1000, 0);    
        }
        
    }

    public void xyz(int xValue, int yValue){
        if(this.mirror){
            this.x = yValue;
            this.y = xValue;
        }else{
            this.x = xValue;
            this.y = yValue;
        }
    }


    public void y3d(int yValue){
        float square = yValue * yValue;
        this.x = this.y = (int) sqrt(square / 2);
    }

    public void runQuadrant(int quadrant){
        switch (quadrant) {
            case 0:{
                translate(width/2, height/2);
                rotate(radians(-135));
                
                break;
            }
            case 1: {
                rotate(radians(90));
                break;
            }
            case 2: {
                rotate(radians(90));
                break;
            }
            case 3: {
                rotate(radians(90));
                break;
            }
        }
        this._draw();
    }



}