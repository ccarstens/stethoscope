class Caleidoscope extends SettingsReceiver {

    boolean mirror = false;
    

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
        // this.runQuadrant(2);
        // this.runQuadrant(3);



        popMatrix();

        this.y3dCurrent += 1;
    }


    public void _draw(){
        PImage img = loadImage("pill1.png");
        // this.xy(mouseX, mouseY);
        stroke(this.def.PRIM);
        fill(this.def.PRIM);
        
        pushMatrix();   // translation for image position

        

        int x = mouseX - (width / 2);
        int y = (int) map(mouseY, height / 2, 0, 0, height / 2);

        this.xyz(x, y);
        translate(this.pos1.x, this.pos1.y);
        this.drawImage(img);
        
        popMatrix();

        if(this.def.SHOWLINES){
            stroke(this.def.PRIM);
            line(0, 0, 0, 1000);
            line(0, 0, 1000, 0);    
        }
        
    }

    public void xyz(int xValue, int yValue){
        PVector coordinate = new PVector(1, 1);
        coordinate.normalize();
        PVector xcor = new PVector(-1, 1);
        xcor.normalize();
        coordinate.mult(yValue);
        xcor.mult(xValue);
        fill(0, 255, 0);
        noStroke();
        ellipse(coordinate.x, coordinate.y, 3, 3);
        coordinate.add(xcor);
        fill(0, 0, 255);
        ellipse(coordinate.x, coordinate.y, 7, 7);
        this.pos1 = coordinate.copy();

        if(this.pos1.x < 0 || this.pos1.y < 0){
            println("alert");
        }else{
            println("valid");
        }

    }


    // public void y3d(int yValue){
    //     float square = yValue * yValue;
    //     this.x = this.y = (int) sqrt(square / 2);
    // }

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

    public void drawImage(PImage image){
        pushMatrix(); //rotation and scaling for image size and orientation

        rotate(radians(135));
        translate(0, image.height / 2 * -1);
        imageMode(CENTER);

        
        image(image, 0, 0);

        popMatrix();
    }



}