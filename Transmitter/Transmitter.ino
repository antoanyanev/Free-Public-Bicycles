#include <TinyGPS++.h>
#include <SoftwareSerial.h>
#include <SPI.h>
#include <LoRa.h>
#include <EEPROM.h>
#include <Sleep_n0m1.h>

#define RXPIN 9
#define TXPIN 8
#define BTPIN A0
#define GPSCTRLPIN A5
#define BAND 868E6
#define HDOPMIN 270

TinyGPSPlus gps;
SoftwareSerial gpsSerial(RXPIN, TXPIN);
Sleep sleep;

int id;
int LoRasend = 0;
int hdop_value = 100;
int info = 0;

char _latitude[16];
char _longitude[16];
char temp[16];
char _packet[64];

void check_gps_connected();
void gps_read_info();
void get_info();
void send_info();
void receive_info();
void create_info_packet();
void create_button_packet();
void button_interrupt();
void check_button();

unsigned long sleep_time; // How the arduino sleeps

void setup() {
    pinMode(GPSCTRLPIN, OUTPUT);
    digitalWrite(GPSCTRLPIN, LOW);
  
    Serial.begin(9600);
    sleep_time = 60000;

    Serial.begin(9600);
    gpsSerial.begin(9600);
    while (!Serial);

    LoRa.setPins(10, 7, 2);

    pinMode(BTPIN, INPUT_PULLUP);

    id = EEPROM.read(0);
}

void loop() {
    delay(100);

    // Turn on GPS
    delay(20);
    digitalWrite(GPSCTRLPIN, LOW);
    delay(20);

    // Wait for accurate data
    // Get data
    gps_read_info();

    // Turn off GPS
    delay(20);
    digitalWrite(GPSCTRLPIN, HIGH);
    delay(20);

    // Turn on LoRa

    LoRa.begin(BAND);

    // Send data
    send_info();

    // Turn off LoRa
    LoRa.end();

    Serial.print("sleeping for ");
    Serial.println(sleep_time); 
    delay(100);
    
    sleep.pwrDownMode(); // Set sleep mode
    sleep.sleepDelay(sleep_time); // Sleep for: sleep_time 
}

void check_gps_connected() {
    if (millis() > 5000 && gps.charsProcessed() < 10) {
        Serial.println("No GPS detected");
        while (true) { }
    }
}

void send_info() {
    create_info_packet();
    Serial.println(_packet);
    LoRa.beginPacket();
    LoRa.print(_packet);
    LoRa.endPacket();
}

void get_info() {
    if (gps.location.isValid()) {
        dtostrf(gps.location.lat(), 1, 6, temp);
        sprintf(_latitude, "%s", temp);
        dtostrf(gps.location.lng(), 1, 6, temp);
        sprintf(_longitude, "%s", temp);
        hdop_value = gps.hdop.value();

        if (hdop_value < 270) {
            info = 1;
        }
    }
}

void receive_info() {
    int i = 0;
    char reply[7];
    int packetSize = LoRa.parsePacket();

    while (!packetSize) {
        packetSize = LoRa.parsePacket();
    }

    if (packetSize) {
        Serial.print("Received packet ");

        while (LoRa.available()) {
            reply[i] = (char)LoRa.read();
            i++;
        }

        // LED Feedback

        Serial.println(reply);
    } 
}

void gps_read_info() {
    while (1) {
        while (gpsSerial.available() > 0) {
            if (gps.encode(gpsSerial.read())) {
                get_info();
                if (info) {
                    info = 0;
                    return;
                }
            }
        }
    }
}

void create_info_packet() {
    sprintf(_packet, "%d, %s, %s", id, _latitude, _longitude);
}

void create_button_packet() {
    sprintf(_packet, "%d, button", id);
}

void check_button() {
    if (!digitalRead(BTPIN)) {
        static unsigned long last_interrupt_time = 0;
        unsigned long interrupt_time = millis();

        if (interrupt_time - last_interrupt_time > 200) {
            if (!digitalRead(BTPIN)) {
                create_button_packet();
                LoRa.beginPacket();
                LoRa.print(_packet);
                LoRa.endPacket();
                delay(10);
                receive_info();
            }
        }
        
        last_interrupt_time = interrupt_time;
    }
}