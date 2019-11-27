#include <TinyGPS++.h>
#include <SoftwareSerial.h>
#include <LoRaLib.h>

#define RXPIN 9
#define TXPIN 8

TinyGPSPlus gps;
SX1276 lora = new LoRa(6, 7, 4);
SoftwareSerial gpsSerial(RXPIN, TXPIN);

char _latitude[16];
char _longitude[16];
char temp[16];

uint8_t _day;
uint8_t _month;
int _year;

uint8_t _hour;
uint8_t _minute;
uint8_t _second;

int read_data_count = 0;

char _packet[64];
int state;

void get_info();
void create_packet();

void setup() {
  Serial.begin(9600);
  gpsSerial.begin(9600);

  state = lora.begin(868, 125, 9, 7, 0x12, 17, 100, 8, 0);

  if (state == ERR_NONE) {
    Serial.println("Success!");
  } else {
    while (true) { }
  }

  digitalWrite(7, HIGH);
  delay(10);
  digitalWrite(7, LOW);
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

  if (read_data_count == 8) {
    create_packet();
    state = lora.transmit(_packet);

    if (state == ERR_NONE) {
      Serial.println("Successfully sent data.");
    } else if (state == ERR_PACKET_TOO_LONG) {
      Serial.println("Packet is too long.");
    } else if (state == ERR_TX_TIMEOUT) {
      Serial.println("Timeout!");
    }

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