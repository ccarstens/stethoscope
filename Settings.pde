class Settings{



    public PApplet instance;

    public int BACKGROUND = color(0);
    public int DECIMALS = 10;
    public int FRAMERATE = 25;
    public boolean LOG = false;

    public int PRIM = color(255, 0, 0);

    public boolean TESTING = true;

    public String AUDIOINPUTCHANNEL = "Soundflower (2ch)";

    public Minim GLOBALMINIM;

    public int STANDARDBUFFERSIZE = 1700;

    public boolean SHOWLINES = true;

    public int PARTICLESIZE = 30;

    Settings(PApplet instance){
        this.instance = instance;
        this.GLOBALMINIM = new Minim(this.instance);
    }
}