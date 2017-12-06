

class Impulsator extends SettingsReceiver{

    
    

    float floor;
    float ceiling;
    BigDecimal step;
    ArrayList<BigDecimal> range;

    int direction = 1;
    int position;
    int speed;

    int steps;

    Impulsator(Settings def, float floor, float ceiling, int steps, int speed){
        super(def);
        
        this.floor = floor;
        this.ceiling = ceiling;
        this.steps = steps;
        this.speed = speed;

        this.step = this.getStep();

        this.range = this.getRange();
        
    }

    ArrayList<BigDecimal> getRange(){


        ArrayList<BigDecimal> temp = new ArrayList<BigDecimal>();
        temp.add(new BigDecimal(this.floor));
        BigDecimal tempvalue = new BigDecimal(this.floor);
        for(int i = 0; i < this.steps; i++){
            tempvalue = tempvalue.add(this.step);
            temp.add(tempvalue);
        }

        return temp;
    }


    BigDecimal getStep(){
        BigDecimal area = new BigDecimal(this.ceiling - this.floor);
        
        return area.divide(new BigDecimal(this.steps), def.DECIMALS, BigDecimal.ROUND_HALF_EVEN);
    }


    BigDecimal read(){
        this.log("Start");
        // int amount = this.range.size() / def.FRAMERATE / 4;
        int amount = this.speed;
        int newPosition = amount * direction + this.position;
        if(newPosition < 0 || newPosition >= this.range.size()){

            this.direction *= -1;
        }

        newPosition = amount * direction + this.position;
        this.position = newPosition;
        return this.range.get(this.position);
    }

    void log(String area){
        if(def.LOG){
            println(area + "\nPosition: " + this.position);
        }
        
    }

    int readTransformed(int floor, int ceiling){
        BigDecimal value = this.read();
        BigDecimal result = value.multiply(new BigDecimal(ceiling - floor));
        return result.intValue() + floor;
    }

    int readSine(int floor, int ceiling){
        return (int)sin(this.readTransformed(floor, ceiling));
    }


}