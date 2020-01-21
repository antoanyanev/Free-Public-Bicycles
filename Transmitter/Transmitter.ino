#include <TinyGPS++.h>
#include <SoftwareSerial.h>
#include <SPI.h>
#include <LoRa.h>
#include <EEPROM.h>

#define RXPIN 9
#define TXPIN 8

TinyGPSPlus gps;
SoftwareSerial gpsSerial(RXPIN, TXPIN);

int id;
int read_data_count = 0;

char _latitude[16];
char _longitude[16];
char temp[16];
char _packet[64];

void check_gps_connected();
void gps_read_info();
void get_info();
void send_info();
void create_info_packet();
void create_button_packet();
void button_interrupt();
void check_button();

void setup() {
  Serial.begin(9600);
  gpsSerial.begin(9600);
  while (!Serial);

  LoRa.setPins(10, 7, 2);

  if (!LoRa.begin(868E6)) {
    Serial.println("Startling LoRa failed!");
    while (1);
  }

  pinMode(A0, INPUT_PULLUP);

  id = EEPROM.read(0);
}

void loop() {
  gps_read_info();
  check_gps_connected();
  send_info();
  check_button();
}

void check_gps_connected() {
  if (millis() > 5000 && gps.charsProcessed() < 10) {
    Serial.println("No GPS detected");
    while (true) { }
  }
}

void send_info() {
  if (read_data_count == 8 * 6 * 5) {
    create_info_packet();
    Serial.println(_packet);
    LoRa.beginPacket();
    LoRa.print(_packet);
    LoRa.endPacket();
    read_data_count = 0;
  }
}

void get_info() {
  if (gps.location.isValid()) {
    dtostrf(gps.location.lat(), 1, 6, temp);
    sprintf(_latitude, "%s", temp);
    dtostrf(gps.location.lng(), 1, 6, temp);
    sprintf(_longitude, "%s", temp);
  }
}

void gps_read_info() {
  while (gpsSerial.available() > 0) {
    if (gps.encode(gpsSerial.read())) {
      get_info();
      read_data_count++;
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
  if (!digitalRead(A0)) {
    static unsigned long last_interrupt_time = 0;
    unsigned long interrupt_time = millis();

    if (interrupt_time - last_interrupt_time > 200) {
      if (!digitalRead(A0)) {
        create_button_packet();
        Serial.println(_packet);
        LoRa.beginPacket();
        LoRa.print(_packet);
        LoRa.endPacket();
      }
    }
    
    last_interrupt_time = interrupt_time;
  }
}