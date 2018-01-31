class Caleidoscope extends SettingsReceiver {

    public float x, y, z;

    public float zDepth = -1500;

    public float xWidth = 765;
    
    int currentQuadrant;

    public PVector location, globalVelocity;

    public ArrayList<Particle> particles;

    public boolean play = true;

    PImage overlay;

    public int overlayOffset;

    public Caleidoscope(Settings def){
        super(def);
        this.particles = new ArrayList<Particle>();
        this.globalVelocity = new PVector(0, 0, 0);
        this.overlay = loadImage("overlay.png");
        this.overlayOffset = this.def.PARTICLESIZE / -2;

    }

    public void togglePlay(){
        this.play = !this.play;
    }

//765
    public void _draw() {
        fill(255, 0, 0);
        noStroke();
        this.dropDepthLines(); 
        
        pushMatrix();



        image(this.overlay, this.overlayOffset, this.overlayOffset);
        
        translate(0, 0, this.zDepth / 3);
        
        image(this.overlay, this.overlayOffset, this.overlayOffset);

        translate(0, 0, this.zDepth / 1.5);
        
        image(this.overlay, this.overlayOffset, this.overlayOffset);

        popMatrix();
        // println(this.y);
        
        // PVector location = this.toCurrentQuadrant(
        //     new PVector(
        //                 map(mouseX * 4, 0, width, -765, 765), 
        //                 600, 
        //                 map(mouseY * 4, 0, height, this.zDepth, 0)
        //             )
        // );

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
        if(frameCount % 10 == 0){            
            Particle p = new Particle(this.def, 
                new PVector(random(this.xWidth * -1, this.xWidth), 0, random(this.zDepth, 0))
            );

            p.acceleration = new PVector(0, 0, 0);

            this.particles.add(p);
        }

    }

    public void updateParticles(){
        Iterator<Particle> it = this.particles.iterator();
        int i = 0;
        while(it.hasNext()){
            Particle p = it.next();
            PVector fluidResistance = this.getFluidResistanceForParticle(p);
            // println(i);
            // println("Before Application");
            // println("p.acceleration: "+p.acceleration);
            // println("p.velocity: "+p.velocity);
            // println("fluidResistance: "+fluidResistance);
            // println("\n");
            p.applyForce(new PVector(0, 0.1, 0));
            // if(frameCount > 150) p.applyForce(fluidResistance);
            // println("After Application");
            // println("p.acceleration: "+p.acceleration);
            // println("p.velocity: "+p.velocity);
            // println("\n");
            p.update();
            
            // println("After Update");
            // println("p.acceleration: "+p.acceleration);
            // println("p.velocity: "+p.velocity);

            // println("\n\n\n\n\n");
            if(p.location.y > 1200) it.remove();

            i++;
        }
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

    public boolean hologramCoordinateIsInBounds(PVector hologramCoordinate){
        return this.isInBounds(this.hologramToWorld(hologramCoordinate));
    }

    public boolean isInBounds(PVector coordinate){
        return coordinate.x >= 0 && coordinate.y >= 0;
    }

    public boolean isInBounds(Particle p){
        return this.isInBounds(p.location);
    }



    public void magic(float strength) {
        this.globalVelocity.y = strength;
        if(this.play){
            this.addParticles();
            this.updateParticles();
        }
        noStroke();
        fill(0, 255, 255);
        ellipse(0, 0, 30, 30);
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
                this.setParticleColor(color(255, 0, 0));
                break;
            }
            case 1:{
                xRotate = 0.0;
                yRotate = -18.0;
                zRotate = -45.0;
                this.setParticleColor(color(0, 255, 0));
                break;
            }
            case 2:{
                xRotate = 18.0;
                yRotate = 0.0;
                zRotate = 45.0;
                this.setParticleColor(color(0, 0, 255));
                break;
            }
            case 3:{
                xRotate = 0.0;
                yRotate = 18.0;
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

}