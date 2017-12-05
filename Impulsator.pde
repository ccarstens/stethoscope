

class Impulsator extends SettingsReceiver{

    static final int test = 7;
    

    BigDecimal value;
    BigDecimal floor;
    BigDecimal ceiliing;
    BigDecimal[] step;

    Impulsator(Settings def, int steps){
        super(def);
        
        BigDecimal bd = new BigDecimal("1.5");
        BigDecimal t = new BigDecimal(0.239847239847293847);
        BigDecimal r = bd.divide(t, 6, BigDecimal.ROUND_HALF_EVEN);

        println(r.toString());

        println(def.BACKGROUND);

    }
}