class Particle extends SettingsReceiver {

    public PVector location, velocity, acceleration;
    
    public Particle(Settings def, PVector _location){
        super(def);
        this.location = _location.copy();
        this.velocity = this.acceleration = new PVector(0, 0, 0);

    }

    public void update(PVector force) {
        this.applyForce(force);
        this.velocity.add(this.acceleration);
        this.location.add(this.velocity);
    }

    public void applyForce(PVector force) {
        this.acceleration.add(force);
    }
}