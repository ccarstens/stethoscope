class Caleidoscope extends SettingsReceiver {

    

    public Caleidoscope(Settings def){
        super(def);
        
    }


    public void _draw() {
        fill(255, 0, 0);
        noStroke();
        pushMatrix();
        translate(0, 0, map(mouseX, 0, width, 0, -1000));
        float a = map(mouseY, 0, height, 0, 600);
        ellipse(a, a, 100, 100);

        popMatrix();
    }



    public void magic() {
        for(int i = 0; i < 4; i++){
            this.runQuadrant(i);
        }
    }


    public void run(float xRotate, float yRotate, float zRotate) {
        pushMatrix();
        rotateX(radians(xRotate));
        rotateY(radians(yRotate));
        rotateZ(radians(zRotate));
        translate(27, 27);


        
        this._draw();

        popMatrix();
    }


    public void runQuadrant(int i) {
        float xRotate, yRotate, zRotate;
        switch(i){
            case 0:{
                xRotate = -18.0;
                yRotate = 0.0;
                zRotate = -135.0;
                break;
            }
            case 1:{
                xRotate = 0.0;
                yRotate = -18.0;
                zRotate = -45.0;
                break;
            }
            case 2:{
                xRotate = 18.0;
                yRotate = 0.0;
                zRotate = 45.0;
                break;
            }
            case 3:{
                xRotate = 0.0;
                yRotate = 18.0;
                zRotate = 135.0;
                break;
            }
            default:{
                xRotate = 0;
                yRotate = 0;
                zRotate = 0;
            }
        }
        this.run(xRotate, yRotate, zRotate);
    }

}