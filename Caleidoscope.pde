class Caleidoscope extends SettingsReceiver {

    public float x, y, z;

    public float zDepth = -1500;

    public float xWidth = 765;
    
    int currentQuadrant;

    public PVector location;

    public ArrayList<Particle> particles;

    public Caleidoscope(Settings def){
        super(def);
        this.particles = new ArrayList<Particle>();
    }

//765
    public void _draw() {
        fill(255, 0, 0);
        noStroke();
        // this.dropDepthLines();
        
        // println(this.y);
        
        PVector location = this.toCurrentQuadrant(
            new PVector(
                        map(mouseX * 4, 0, width, -765, 765), 
                        600, 
                        map(mouseY * 4, 0, height, this.zDepth, 0)
                    )
        );

        

        pushMatrix();

        if(this.hologramCoordinateIsInWorldBounds(location)){
            location = this.hologramToWorld(location);
            translate(location.x, location.y, location.z);
            ellipse(0, 0, 100, 100);            
        }


        popMatrix();
    }

    public void addParticles(){
        this.particles.add(new Particle(this.def, new PVector(
            0, 0, 0
        )));
    }

    public PVector toCurrentQuadrant(PVector location){

        PVector tmp = location.copy();

        if(this.isQuadrant(1)){
            tmp.x = map(location.z, 0, this.zDepth, this.xWidth * -1, this.xWidth);
            tmp.z = map(location.x, this.xWidth * -1, this.xWidth, this.zDepth, 0);
        }else if(this.isQuadrant(2)){
            tmp.x *= -1;
            tmp.z = map(location.z, this.zDepth, 0, 0, this.zDepth);
        }else if(this.isQuadrant(3)){
            tmp.x = map(location.z, 0, this.zDepth, this.xWidth, this.xWidth * -1);
            tmp.z = map(location.x, this.xWidth, this.xWidth * -1, this.zDepth, 0);
        }


        return tmp;
    }

    public PVector hologramToWorld(PVector hologramCoordinate){


        PVector coordinate = new PVector(1, 1).normalize();
        coordinate.mult(hologramCoordinate.y);
        PVector xVector = new PVector(-1, 1).normalize();
        xVector.mult(hologramCoordinate.x);
        coordinate.add(xVector);
        coordinate.z = hologramCoordinate.z;
        
        return coordinate;
        
    }

    public boolean hologramCoordinateIsInWorldBounds(PVector hologramCoordinate){
        return this.isInWorldBounds(this.hologramToWorld(hologramCoordinate));
    }

    public boolean isInWorldBounds(PVector coordinate){
        return coordinate.x >= 0 && coordinate.y >= 0;
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
        this.currentQuadrant = i;

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

    public boolean isQuadrant(int i){
        return this.currentQuadrant == i;
    }

}