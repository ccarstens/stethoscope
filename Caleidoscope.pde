class Caleidoscope extends SettingsReceiver {

    boolean mirror = false;
    
    int x;
    int y;

    Caleidoscope(Settings def){
        super(def);
    }


    public void magic(){
        background(this.def.BACKGROUND);
        pushMatrix();
        translate(width/2, height/2);
        rotate(radians(-135));
        this.mirror = false;
        this._draw();

        rotate(radians(90));
        this.mirror = true;
        this._draw();

        rotate(radians(90));
        this.mirror = false;
        this._draw();

        rotate(radians(90));
        this.mirror = true;
        this._draw();

        popMatrix();
    }


    public void _draw(){
        
        this.xy(mouseX, mouseY);
        stroke(this.def.PRIM);
        fill(this.def.PRIM);
        ellipse(this.x, this.y, 20, 20);

        if(this.def.SHOWLINES){
            line(0, 0, 0, 1000);
            line(0, 0, 1000, 0);    
        }
        
    }

    public void xy(int xValue, int yValue){
        if(this.mirror){
            this.x = yValue;
            this.y = xValue;
        }else{
            this.x = xValue;
            this.y = yValue;
        }
    }



}