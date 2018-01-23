class Mover extends SettingsReceiver{
    
    public PVector location;
    public PVector velocity;

    public Mover(Settings def){
        super(def);
        this.startRandom();
    }

    public void startRandom() {
        this.location = new PVector(random(-500, 500), random(-500, 500), -2000);
        this.velocity = new PVector(0, 0, 20);
    }

    public void run() {
        this.location.add(this.velocity);
        noStroke();
        fill(this.def.PRIM);
        pushMatrix();
        translate(this.location.x, this.location.y, this.location.z);
        ellipse(0, 0, 10, 10);
        popMatrix();
    }
}