#include <TinyGPS++.h>
#include <SoftwareSerial.h>
#include <SPI.h>
#include <LoRa.h>

#define RXPIN 9
#define TXPIN 8

#define INTERVAL 5

TinyGPSPlus gps;
SoftwareSerial gpsSerial(RXPIN, TXPIN);

uint8_t _day;
uint8_t _month;
uint8_t _hour;
uint8_t _minute;
uint8_t _second;

int _year;
int iterations = 0;
int read_data_count = 0;

char _latitude[16];
char _longitude[16];
char temp[16];
char _packet[64];

void get_info();
void create_packet();
void calculate_iterations();

void setup() {
  Serial.begin(9600);
  while (!Serial);

  LoRa.setPins(10, 7, 2);

  if (!LoRa.begin(868E6)) {
    Serial.println("Startling LoRa failed!");
    while (1);
  }

  calculate_iterations();
  gpsSerial.begin(9600);
}

void loop() {
  while (gpsSerial.available() > 0) {
    if (gps.encode(gpsSerial.read())) {
      get_info();
      read_data_count++;
    }
  }

  if (millis() > 5000 && gps.charsProcessed() < 10) {
    Serial.println("No GPS detected");
    while (true) { }
  }

  if (read_data_count == 40) {
    create_packet();
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

  if (gps.date.isValid()) {
    _day = gps.date.day();
    _month = gps.date.month();
    _year = gps.date.year();
  }

  if (gps.time.isValid()) {
    _second = gps.time.second();
    _minute = gps.time.minute();
    _hour = gps.time.hour();
  }
}

void create_packet() {
  sprintf(_packet, "%s, %s, %d/%d/%d, %d:%d:%d", _latitude, _longitude, _day, _month, _year, _hour, _minute, _second);
}

void calculate_iterations() {
  iterations = INTERVAL * 8;
}