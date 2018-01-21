class Caleidoscope extends SettingsReceiver {

    boolean mirror = false;
    
    int x;
    int y;
    int z;

    PVector pos1;


    int y3dCurrent = 0;

    int currentQuadrant;

    Caleidoscope(Settings def){
        super(def);
    }


    public void magic(){
        background(this.def.BACKGROUND);
        pushMatrix();
        translate(width/2, height/2);
        rotate(radians(-225));
        this.runQuadrant(0);
        this.runQuadrant(1);
        this.runQuadrant(2);
        this.runQuadrant(3);



        popMatrix();

        this.y3dCurrent += 1;
    }


    public void _draw(){
        PImage img = loadImage("pill1.png");
        // this.xy(mouseX, mouseY);
        stroke(this.def.PRIM);
        fill(this.def.PRIM);

        pushMatrix();   // translation for image position
        this.xyz(mouseX - mouseY, mouseY);
        translate(this.pos1.x, this.pos1.y);

        pushMatrix(); //rotation and scaling for image size and orientation

        rotate(radians(135));
        translate(0, img.height / 2 * -1);
        imageMode(CENTER);

        ellipse(0, 0, 4, 4);
        
        image(img, 0, 0);

        popMatrix();
        popMatrix();

        if(this.def.SHOWLINES){
            line(0, 0, 0, 1000);
            line(0, 0, 1000, 0);    
        }
        
    }

    public void xyz(int xValue, int yValue){
        PVector coordinate = new PVector(1, 1);
        PVector xcor = new PVector(xValue, 0);
        coordinate.mult(yValue);
        coordinate.add(xcor);
        this.pos1 = coordinate.copy();

    }


    public void y3d(int yValue){
        float square = yValue * yValue;
        this.x = this.y = (int) sqrt(square / 2);
    }

    public void runQuadrant(int quadrant){
        this.currentQuadrant = quadrant;
        switch (quadrant) {
            case 0:{
                
                rotate(radians(90));
                
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