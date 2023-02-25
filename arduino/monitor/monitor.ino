#define CLK 2

const char ADDR[] = {22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 52};

void setup(){
    pinMode(CLK, INPUT);
	for (int n = 0; n < 16; n++) {
        pinMode(ADDR[n], INPUT);
    }

    attachInterrupt(digitalPinToInterrupt(CLK), onClock, RISING);

    Serial.begin(115200);
}

void onClock(){
	for (int i = 0; i < 16; i++) {
        int bit = digitalRead(ADDR[i]) ?  1 : 0;
        Serial.print(bit);
    }
    Serial.println();
}

void loop(){
    
}