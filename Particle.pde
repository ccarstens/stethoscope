class Particle extends SettingsReceiver {

    public PVector location, velocity, acceleration;

    public color c;

    public int size;

    PImage img;

    public boolean triggeredNew = false;
    
    public Particle(Settings def, PVector _location){
        super(def);
        this.location = _location.copy();
        this.velocity = new PVector(0, 0, 0);
        this.acceleration = new PVector(0, 0, 0);
        // this.c = color(random(0, 255), random(0, 255), random(0, 255));
        this.c = color(255, 0, 0);
        this.size = this.def.PARTICLESIZE;
        this.img = loadImage("CELL.png");
    }

    public void update() {
        // this.applyForce(force);
        this.velocity.add(this.acceleration);
        this.location.add(this.velocity);
        this.acceleration.mult(0);
    }

    public void applyForce(PVector force) {
        this.acceleration.add(force);
    }

    public void displayAt(PVector loc){
        
        loc = this.hologramToWorld(loc);

        fill(this.c);
        noStroke();
        pushMatrix();
        translate(loc.x, loc.y, loc.z);
        
        image(this.img, 0, 0);

        popMatrix();
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
}