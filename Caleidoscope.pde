class Caleidoscope extends SettingsReceiver {

    

    public Caleidoscope(Settings def){
        super(def);
        
    }


    public void _draw() {
        fill(255, 0, 0);
        noStroke();
        this.dropDepthLines();
        
        pushMatrix();
        PVector location = xyz(
            map(mouseX, 0, width, -500, 500),
            map(mouseY, 0, height, 1000, 0),
            0);
        if(location != null){
            translate(location.x, location.y, location.z);
            ellipse(0, 0, 100, 100);            
        }


        popMatrix();
    }

    PVector xyz(float x, float y, float z){
        PVector coordinate = new PVector(1, 1).normalize();
        coordinate.mult(y);
        PVector xVector = new PVector(-1, 1).normalize();
        xVector.mult(x);
        coordinate.add(xVector);
        coordinate.z = z;
        
        if(coordinate.x >= 0 && coordinate.y >= 0) return coordinate;
        else return null;
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

    public void dropDepthLines(){
        int c, _c;
        c = 0;
        _c = _cross / 6;
        pushMatrix();
        stroke(255, 255, 0);
        strokeWeight(1);

        for(int x = 0; x <= 1000; x += step){
            for(int y = 0; y <= 1000; y += step){
                line(x, y, c, x, y, _c);
            }
            

        }
        popMatrix();
}

}