class SinePlotter extends SettingsReceiver{

    public int graphWidth;
    public int x;
    public int y;
    public int amplifier;
    public int waveCount = 1;

    public int offsetX;
    public int offsetY;


    public SinePlotter(Settings def, int graphWidth){
        super(def);
        this.graphWidth = graphWidth;
        this.waveCount = waveCount;
    }

    public void plot(){
        for(this.x = 0; this.x < this.graphWidth; this.x++){
            this.y = (int)(sin((float)this.x / (float)this.graphWidth * this.waveCount * PI * 1) * this.amplifier);

            stroke(def.PRIM);
            fill(def.PRIM);

            int xFill = this.x + this.offsetX;
            int yFill = this.y + this.offsetY;

            ellipse(xFill, yFill, 2, 2);
        }
    }

    public void setOffsets(int offsetX, int offsetY){
        this.offsetX = offsetX;
        this.offsetY = offsetY;
    }


}