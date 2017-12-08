class AudioBufferController extends SettingsReceiver{
    AudioBuffer buffer;

    AudioBufferController(Settings def, AudioBuffer buffer){
        super(def);
        this.buffer = buffer;
    }
}