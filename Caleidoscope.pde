class Caleidoscope extends SettingsReceiver {

    public float x, y, z;

    public float zDepth = -1500;

    public float xWidth = 90;
    
    int currentQuadrant;

    public PVector location, globalVelocity;

    public ArrayList<Particle> particles;

    public boolean play = true;

    PImage overlay;

    public int overlayOffset;

    public boolean pump;

    public int globalTilt = 11;
    public int _globalTilt;

    public int triggerNewValue = 90;
    public int deleteValue = 700;

    public boolean addOne = false;

    public Caleidoscope(Settings def){
        super(def);
        this.particles = new ArrayList<Particle>();
        this.globalVelocity = new PVector(0, 0, 0);
        this.overlay = loadImage("overlay.png");
        // this.overlayOffset = this.def.PARTICLESIZE / -2;
        this.overlayOffset = 0;
        this._globalTilt = this.globalTilt * -1;

        this.addParticles();
    }

    public void togglePlay(){
        this.play = !this.play;
    }

//765
    public void _draw() {
        fill(255, 0, 0);
        noStroke();
        // this.dropDepthLines(); 

        // this.dropOverlay();
        // this.dropEdges();
        
        

        Iterator<Particle> it = this.particles.iterator();

        while(it.hasNext()){
            Particle p = it.next();
            PVector locationInQuadrant = this.toCurrentQuadrant(p.location);
            if(this.hologramCoordinateIsInBounds(locationInQuadrant)){

                p.displayAt(locationInQuadrant);
            }
        }


    }

    public void addParticles(){
        this.addOne = false;
                
        Particle p = new Particle(this.def, 
            new PVector(random(this.xWidth * -1, this.xWidth), 0, random(this.zDepth, 0))
        );

        p.acceleration = new PVector(0, 0, 0);

        this.particles.add(p);
        

    }

    public void updateParticles(){

        if(this.addOne) this.addParticles();

        ListIterator<Particle> it = this.particles.listIterator();
        int i = 0;
        while(it.hasNext()){
            Particle p = it.next();
            PVector fluidResistance = this.getFluidResistanceForParticle(p);
            p.applyForce(fluidResistance);

            if(this.pump){
                
                
                p.applyForce(new PVector(0, 7, 0));
            }

            p.update();
            
            if(p.location.y > this.triggerNewValue && !p.triggeredNew){
                p.triggeredNew = true;
                this.addOne = true;
            }

            if(p.location.y > this.deleteValue) it.remove();

            i++;
        }
        if(this.pump ) this.pump = false;
    } 

    public void setParticleColor(color c) {
        Iterator<Particle> it = this.particles.iterator();
        while(it.hasNext()){
            Particle p = it.next();
            p.c = c;
        }
    }

    public PVector getFluidResistanceForParticle(Particle particle) {
        float c = 0.1;
        float speed = particle.velocity.mag();
        float resistanceMagnitude = c * speed * speed;

        PVector resistance = particle.velocity.copy();
        resistance.normalize();
        resistance.mult(-1);
        resistance.mult(resistanceMagnitude);
        return resistance;
    }

    public PVector toCurrentQuadrant(PVector location){

        PVector tmp = location.copy();

        if(this.def.DEPTHMAPPING){
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
        }else{
            if(this.isQuadrant(2) || this.isQuadrant(3)){
                tmp.x *= -1;
            }
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

    public boolean hologramCoordinateIsInBounds(PVector hologramCoordinate){
        return this.isInBounds(this.hologramToWorld(hologramCoordinate));
    }

    public boolean isInBounds(PVector coordinate){
        if(coordinate.z < 400){
            return coordinate.x >= -200 && coordinate.y >= -200;
        }
        return coordinate.x >= 0 && coordinate.y >= 0;
    }

    public boolean isInBounds(Particle p){
        return this.isInBounds(p.location);
    }



    public void magic(float strength) {
        this.globalVelocity.y = strength;
        if(this.play){
            this.updateParticles();
        }
        
        for(int i = 0; i < 4; i++){
            this.runQuadrant(i);
        }
    }


    public void run(float xRotate, float yRotate, float zRotate) {
        pushMatrix();
        rotateX(radians(xRotate));
        rotateY(radians(yRotate));
        rotateZ(radians(zRotate));
        translate(0, 0);
        
        this._draw();

        popMatrix();
    }


    public void runQuadrant(int i) {
        this.currentQuadrant = i;

        float xRotate, yRotate, zRotate;

        switch(i){
            case 0:{
                xRotate = this._globalTilt;
                yRotate = 0.0;
                zRotate = -135.0;
                this.setParticleColor(color(255, 0, 0));
                break;
            }
            case 1:{
                xRotate = 0.0;
                yRotate = this._globalTilt;
                zRotate = -45.0;
                this.setParticleColor(color(0, 255, 0));
                break;
            }
            case 2:{
                xRotate = this.globalTilt;
                yRotate = 0.0;
                zRotate = 45.0;
                this.setParticleColor(color(0, 0, 255));
                break;
            }
            case 3:{
                xRotate = 0.0;
                yRotate = this.globalTilt;
                zRotate = 135.0;
                this.setParticleColor(color(255, 255, 0));
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

    public void dropOverlay(){
        pushMatrix();

        translate(0, 0, this.currentQuadrant);


        image(this.overlay, this.overlayOffset, this.overlayOffset);
        
        translate(0, 0, this.zDepth / 3);
        
        image(this.overlay, this.overlayOffset - 15, this.overlayOffset - 15);

        translate(0, 0, this.zDepth / 1.5);
        
        image(this.overlay, this.overlayOffset - 30, this.overlayOffset - 30);

        popMatrix();
    }

    public void dropEdges() {
        pushMatrix();
        translate(0, 0, 5);
        noStroke();
        fill(0, 255, 255);
        ellipse(0, 0, 30, 30);

        stroke(this.def.PRIM);
        line(0, 0, 0, 1000);
        line(0, 0, 1000, 0);

        popMatrix();


    }

}