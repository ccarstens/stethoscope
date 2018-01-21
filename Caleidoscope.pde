class Caleidoscope extends SettingsReceiver {

    boolean mirror = false;
    

    PVector pos1;


    int y3dCurrent = 0;

    int currentQuadrant;

    boolean offBounds;

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

        

        int x = mouseX - (width / 2);
        // int y = (int) map(mouseY, height / 2, 0, 0, height / 2);
        int y = 200;

        int z = (int) map(mouseY, height / 2, 0, 0, height / 2);

        this.xyz(x, y, z);
        translate(this.pos1.x, this.pos1.y, this.pos1.z);
        this.drawImage(img);
        
        popMatrix();

        if(this.def.SHOWLINES){
            stroke(this.def.PRIM);
            line(0, 0, 0, 1000);
            line(0, 0, 1000, 0);    
        }
        
    }

    public void xyz(int xValue, int yValue, int zValue){
        int x, y, z;
        this.offBounds = false;
        y = yValue;
        if(this.currentQuadrant == 0){
            x = xValue * -1;
            z = zValue;

        }else if(this.currentQuadrant == 1){
            
            x = zValue;
            z = xValue;
            
        }else if(this.currentQuadrant == 3){
            x = zValue * -1;
            z = xValue * -1;
        }else{
            x = xValue;
            
            z = zValue * -1;
        }
        PVector coordinate = new PVector(1, 1, 0);
        coordinate.normalize();
        PVector xcor = new PVector(1, -1, 0);
        xcor.normalize();
        PVector zcor = new PVector(0, 0, 1);
        zcor.normalize();

        coordinate.mult(y);
        xcor.mult(x);
        zcor.mult(z);

        fill(0, 255, 0);
        noStroke();
        ellipse(coordinate.x, coordinate.y, 3, 3);


        coordinate.add(xcor);
        coordinate.add(zcor);

        fill(0, 0, 255);
        ellipse(coordinate.x, coordinate.y, 7, 7);


        this.pos1 = coordinate.copy();


        if(this.pos1.x < 0 || this.pos1.y < 0){
            this.offBounds = true;
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
        if(!this.offBounds){
            pushMatrix(); //rotation and scaling for image size and orientation

            rotate(radians(135));
            translate(0, image.height / 2 * -1);
            imageMode(CENTER);

            
            image(image, 0, 0);

            popMatrix();
        }

    }



}