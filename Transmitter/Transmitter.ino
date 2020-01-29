#include <TinyGPS++.h>
#include <SoftwareSerial.h>
#include <SPI.h>
#include <LoRa.h>
#include <EEPROM.h>
#include <Sleep_n0m1.h>

#define RXPIN 9
#define TXPIN 8
#define NSS 10
#define RESET 7
#define DIO0 2
#define GPSCTRLPIN A5
#define WAKEPIN 3
#define BAND 868E6
#define HDOPMIN 10000

TinyGPSPlus gps;
SoftwareSerial gpsSerial(RXPIN, TXPIN);
Sleep sleep;

int id;
int LoRasend = 0;
int hdop_value = 100;
int info = 0;

boolean sleeping = false;
boolean abort_cycle;

char _latitude[16];
char _longitude[16];
char last_latidude[16];
char last_longitude[16];
char temp[16];
char _packet[64]; 

void gps_read_info();
void get_info();
void send_info();
void create_info_packet();
void create_button_packet();
void button_interrupt();
void check_button();
void control();
int are_equal(char arr1[], char arr2[], int n, int m);

unsigned long sleep_time; // How the arduino sleeps

void setup() {
    pinMode(WAKEPIN, INPUT_PULLUP);
    pinMode(GPSCTRLPIN, OUTPUT);
    digitalWrite(GPSCTRLPIN, HIGH);
  
    sleep_time = 300000;

    Serial.begin(9600);
    gpsSerial.begin(9600);
    while (!Serial);

    LoRa.setPins(NSS, RESET, DIO0);
    id = EEPROM.read(0);

    abort_cycle = false;
  
    attachInterrupt(digitalPinToInterrupt(WAKEPIN), button_click, FALLING);

    Serial.println("Setup done");
}

void loop() {
    delay(100);
    sleeping = false;
    Serial.println("Waiting for GPS Info");
    
    control();
    
    Serial.print("sleeping for ");
    Serial.println(sleep_time); 
    delay(100);
    
    sleeping = true;

    sleep.pwrDownMode(); // Set sleep mode
    sleep.sleepDelay(sleep_time, abort_cycle); // Sleep for: sleep_time 
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
        Serial.println(hdop_value);

        if (hdop_value < HDOPMIN && (!are_equal(_latitude, last_latidude, 16, 16) || !are_equal(_longitude, last_longitude, 16, 16))) {
            info = 1;
        }
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

void button_click() {
    static unsigned long last_interrupt_time = 0;
    unsigned long interrupt_time = millis();

    if (interrupt_time - last_interrupt_time > 200) {
            // detachInterrupt(digitalPinToInterrupt(WAKEPIN));

            if (sleeping) {
                abort_cycle = true;
            }
  
            create_button_packet();
            LoRa.beginPacket();
            LoRa.print(_packet);
            LoRa.endPacket();
            delay(10);
          
            if (sleeping) {
                abort_cycle = false;
            }

    }
    
    last_interrupt_time = interrupt_time; 
}

void control() {
    digitalWrite(GPSCTRLPIN, HIGH); // Turn on GPS
    delay(20);
    
    // Wait for accurate data
    // Get data
    gps_read_info();
    
    delay(20); // Turn off GPS
    digitalWrite(GPSCTRLPIN, LOW);
    delay(20);
    
    LoRa.begin(BAND); // Turn on LoRa
    
    send_info(); // Send data
    
    LoRa.end(); // Turn off LoRa
    
    strncpy(last_latidude, _latitude, 16);
    strncpy(last_longitude, _longitude, 16);
}

int are_equal(char arr1[], char arr2[], int n, int m) {
    for (int i = 0; i < n; i++) {
        if (arr1[i] != arr2[i]) {
            return 0;
        }
    }

    return 1;
}
