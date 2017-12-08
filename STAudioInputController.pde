class STAudioInputController extends SettingsReceiver{
    public STAudioInput stethoscope;


    STAudioInputController(Settings def){
        super(def);

        this.stethoscope = new STAudioInput(def, def.GLOBALMINIM, def.AUDIOINPUTCHANNEL);

        

    }


    public void calculateBufferPartialAverage(int resolution){


        for(int i = 0; i < resolution; i++){
            float[] bufferPartial = this.stethoscope.getBufferPartial(i, resolution);
            println("start" + i);
            println(bufferPartial);
        }

    }




}