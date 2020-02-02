#include <TinyGPS++.h> // Include GPS decode library
#include <SoftwareSerial.h> // Include software serial library
#include <SPI.h> // Include SPI communication library
#include <LoRa.h> // Include LoRa library
#include <EEPROM.h> // Include EEPROM library
#include <Sleep_n0m1.h> // Include power management library

#define RXPIN 9 // Software serial interface RX pin
#define TXPIN 8 // Software serial interface TX pin
#define NSS 10 // LoRa module Chip Select pin
#define RESET 7 // LoRa module Reset pin
#define DIO0 2 // LoRa module DIO0 pin
#define GPSCTRLPIN A5 // GPS power enable pin
#define WAKEPIN 3 // Button pin
#define BATTPIN A3 // Batter percentage measurement pin
#define BAND 868E6 // LoRa module operating frequency
#define HDOPMIN 10000 // Minimum LoRa location information accuracy

TinyGPSPlus gps; // GPS library initialization
SoftwareSerial gpsSerial(RXPIN, TXPIN); // Software serial interface initialization
Sleep sleep; // Power management library initialization

int id; // ID of the bicycle
int hdop_value = 10000; // Current horizontal dimmunition of position 
int info = 0; // Allows transmission of data
int battery;

boolean sleeping = true; // Power state 
boolean abort_cycle; // Aborts sleeping cycle when set to false

char _latitude[16]; // Current latitude
char _longitude[16]; // Current longitude
char last_latidude[16]; // Previously acquired latitude
char last_longitude[16]; // Previously acquired longitude
char temp[16]; // Temporary char array used to convert position data into char array
char _packet[64]; // Assembled packet

void gps_read_info(); // Reads info from GPS
void get_info(); // Handles GPS data
void send_info(); // Sends data packet
void create_info_packet(); // Creates location packet
void create_button_packet(); // Creates button packet
void button_interrupt(); // Handles button press interrupt
void control(); // Main logic
int are_equal(char arr1[], char arr2[], int n, int m); // Cheks if two char arrays are the same
int get_battery_percentage(); // Calculates battery level
double my_map(double x, double in_min, double in_max, double out_min, double out_max); // Modified arduino map function to work with floating point numbers

unsigned long sleep_time; // How the arduino sleeps

void setup() {
    // Set pin modes
    pinMode(WAKEPIN, INPUT_PULLUP);
    pinMode(GPSCTRLPIN, OUTPUT);
    digitalWrite(GPSCTRLPIN, HIGH);
  
    // Set sleep interval
    sleep_time = 300000;

    // Begin serial interfaces
    Serial.begin(9600);
    gpsSerial.begin(9600);
    while (!Serial);

    // Set LoRa control pins
    LoRa.setPins(NSS, RESET, DIO0);
    id = EEPROM.read(0);

    // Set sleep interval abort 
    abort_cycle = false;
  
    // Attach interrupt for button press handling
    attachInterrupt(digitalPinToInterrupt(WAKEPIN), button_click, FALLING);

    // Signal that setup has finished
    Serial.println("Setup done");
}

void loop() {
    delay(100); // Wait for serial printing to finsh
    sleeping = false; // Set sleeping state to awake
    Serial.println("Waiting for GPS Info");  // Wait for GPS info
    
    control(); // Run main logic
    
    // Set controller to sleeping state
    Serial.print("sleeping for ");
    Serial.println(sleep_time); 
    delay(100);
    
    sleeping = false;

    sleep.pwrDownMode(); // Set sleep mode
    sleep.sleepDelay(sleep_time, abort_cycle); // Sleep for: sleep_time 
}

void send_info() { // Send data packet
    create_info_packet(); // Create data packet
    Serial.println(_packet); // Print out packet
    // Send packet
    LoRa.beginPacket(); 
    LoRa.print(_packet);
    LoRa.endPacket();
}

void get_info() { // Extract GPS info
    if (gps.location.isValid()) { // Validate data
        dtostrf(gps.location.lat(), 1, 6, temp); // Convert data to double
        sprintf(_latitude, "%s", temp);
        dtostrf(gps.location.lng(), 1, 6, temp);
        sprintf(_longitude, "%s", temp);
        hdop_value = gps.hdop.value(); // Get hdop value
        Serial.println(hdop_value);

        // Check minimum hdop value and last info
        if (hdop_value < HDOPMIN && (!are_equal(_latitude, last_latidude, 16, 16) || !are_equal(_longitude, last_longitude, 16, 16))) {
            info = 1; // Used in gps_read_info()
        }
    }
}

void gps_read_info() { // Read GPS info
    // Wait for data to match requirements 
    while (1) {
        while (gpsSerial.available() > 0) {
            if (gps.encode(gpsSerial.read())) { // Read GPS info
                get_info(); // Extract info
                if (info) { // Check if data matches requirement
                    info = 0;
                    return; 
                }
            }
        }
    }
}

void create_info_packet() { // Create data packet
    sprintf(_packet, "%d, %s, %s, %d", id, _latitude, _longitude, 80);
}

void create_button_packet() { // Create button packet
    sprintf(_packet, "%d, button", id);
}

void button_click() { // Button press ISR
    // Set interupt timing for debouncing
    static unsigned long last_interrupt_time = 0; // Last time the interrupt was triggered
    unsigned long interrupt_time = millis(); // Time of current interrupt

    if (interrupt_time - last_interrupt_time > 200) { // Check interrupt interval
            if (sleeping) { // Checks controller state
                abort_cycle = true; // Break sleep cycle
            }
  
            LoRa.begin(BAND);
            delay(10);
            create_button_packet(); // Create button press packet
            // Send button packet
            LoRa.beginPacket();
            LoRa.print(_packet);
            LoRa.endPacket();
            delay(10);
            LoRa.end();
          
            if (sleeping) { // Check controller state
                abort_cycle = false; // Reset sleep state
            }
    }
    
    last_interrupt_time = interrupt_time; // Set last interrupt time 
}

void control() { // Main control logic
    // LoRa.end(); // Turn off LoRa
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
    
    // Set last position info
    strncpy(last_latidude, _latitude, 16);
    strncpy(last_longitude, _longitude, 16);
}

int are_equal(char arr1[], char arr2[], int n, int m) { // Check if to char arrays are the same
    for (int i = 0; i < n; i++) {
        if (arr1[i] != arr2[i]) {
            return 0;
        }
    }

    return 1;
}

int get_battery_percentage() { // Calculates battery level
    int measured = analogRead(BATTPIN); // Measured value 0-1023
    double volts = my_map(measured, 0, 1023, 0, 5); // Measured value converted to volts

    if (volts >= 3.7 && volts <= 4.2) { // Check if measured battery level is in the battery's voltage range
        int percentage = (int) my_map(volts, 3.7, 4.2, 0, 100); // Convert voltage to percent
        return percentage;
    }

    return 0;
}

double my_map(double x, double in_min, double in_max, double out_min, double out_max) { // Modified arduino map function to work with floating point numbers
  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}