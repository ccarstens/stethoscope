class Caleidoscope extends SettingsReceiver {

    

    Caleidoscope(Settings def){
        super(def);
    }


    public void magic(){
        this._draw();
    }


    public void _draw(){
        background(this.def.BACKGROUND);
        translate(width/2, height/2);
        rotate(radians(-135));
        ellipse(mouseX, mouseY, 20, 20);
        line(0, 0, 0, 1000);
        line(0, 0, 1000, 0);
    }


}