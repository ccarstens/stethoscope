class STAudioInput extends SettingsReceiver{
    public Minim minim;
    public AudioInput in;
    public Mixer.Info[] mixerInfo;

    public String inputName;

    STAudioInput(Settings def, Minim minim, String inputName){
        super(def);

        this.minim = minim;
        this.mixerInfo = AudioSystem.getMixerInfo();
        this.inputName = inputName;
        this.selectAudioInputByName(this.inputName, def.STANDARDBUFFERSIZE);
    }

    public void selectAudioInputByName(String name, int bufferSize){
        for(int i = 0; i < this.mixerInfo.length; i++){
            String currName = this.mixerInfo[i].getName();
            // println(currName);
            if(currName.equals(name)){
                println("Switching to Line In " + currName);
                Mixer mixer = AudioSystem.getMixer(this.mixerInfo[i]);

                if(this.in != null){
                    this.in.close();
                    this.in = null;
                }

                minim.setInputMixer(mixer);

                this.in = minim.getLineIn(Minim.STEREO, bufferSize);
            }
        }
    }

    public AudioBuffer getBuffer(){
        return this.in.mix;
    }

    public int getBufferSize(){
        return this.in.bufferSize();
    }

    public float getSample(int i){
        return this.in.mix.get(i);
    }

    public void getBufferPartial(){
        
    }

}