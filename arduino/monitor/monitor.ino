#define CLK 2
#define RWB 3

//const char ADDR[] = {22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 52};
const char ADDR[] = {52, 50, 48, 46, 44, 42, 40, 38, 36, 34, 32, 30, 28, 26, 24, 22};
//const char DATA[] = {39, 41, 43, 45, 47, 49, 51, 53};
const char DATA[] = {53, 51, 49, 47, 45, 43, 41, 39};

void setup(){
    pinMode(CLK, INPUT);
    pinMode(RWB, INPUT);
	for (int n = 0; n < 16; n++) {
        pinMode(ADDR[n], INPUT);
    }

    for (int i = 0; i < 8; i++) {
        pinMode(DATA[i], INPUT);
    }

    attachInterrupt(digitalPinToInterrupt(CLK), onClock, RISING);

    Serial.begin(115200);
}

void onClock(){
    char output[15];
    unsigned int address = 0;
	for (int i = 0; i < 16; i++) {
        int bit = digitalRead(ADDR[i]) ?  1 : 0;
        Serial.print(bit);
        address = (address << 1) + bit;
    }
    Serial.print("   ");

    unsigned int data = 0;
    for (int i = 0; i < 8; i++) {
        int bit = digitalRead(DATA[i]) ?  1 : 0;
        Serial.print(bit);
        data = (data << 1) + bit;
    }

    char rwbState = digitalRead(RWB) ? 'r' : 'W';

    sprintf(output, "  %04x  %c %02x", address, rwbState, data);
    Serial.print(output);
    Serial.println();
}

void loop(){

}