class SineImpulse extends SettingsReceiver{

    int resolution;
    int currentStep;
    float x = 0;
    float y;

    float singleStep;

    int amplifier;

    int offsetY = 0;


    public SineImpulse(Settings def, int resolution, int amplifier){
        super(def);
        this.resolution = resolution;
        
        
        this.amplifier = amplifier;
    }

    public float read(){
        this.singleStep = (2 * PI) / (float) this.resolution;
        
        this.y = sin(this.x) * this.amplifier + this.offsetY;
        
        
        float newX = this.x + this.singleStep;

        // if(newX > PI * 2){
        //     newX = 0;
        // }
        this.x = newX;

        // this.log();


        this.currentStep++;
        return this.y;
    }

    public void log(){
        if(def.LOG){
            println("X: " + this.x);
            println("Y: " + this.y);
            println("Amplifier: " + this.amplifier);
            println("\n");
        }
    }
}