class STAudioInputController extends SettingsReceiver{
    public STAudioInput stethoscope;


    STAudioInputController(Settings def){
        super(def);

        this.stethoscope = new STAudioInput(def, def.GLOBALMINIM, def.AUDIOINPUTCHANNEL);

        

    }


    

}