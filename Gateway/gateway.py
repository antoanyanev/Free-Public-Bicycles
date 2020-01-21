import PyLora
import time
import requests
from datetime import datetime

global gateway_id
gateway_id = 101

PyLora.init()
PyLora.set_frequency(868000000)
PyLora.enable_crc()

print("Gateway listening...")

while True:
    PyLora.receive()
    while not PyLora.packet_available():
        time.sleep(0)
    rec = PyLora.receive_packet()
    now = datetime.now().strftime('%Y-%m-%d %H:%M:%S');

    info = rec.split(',')

    bicycle_id = info[0].strip().decode('utf-8')
    latitude = info[1].strip().decode('utf-8')
    longitude = info[2].strip().decode('utf-8')

    try:
        req = requests.put('https://www.freepublicbicycles.org/locations/add', verify=False, json = {
            "bicycle_id": bicycle_id,
            "gateway_id": gateway_id,
            "latitude": latitude,
            "longitude": longitude,
            "timestamp": now,
            "battery": '40'
        });
    except:
        print 'Request Failed'

    print 'Packet received: {}'.format(rec)

def check_packet(packet):
    if ("button" in packet):
        pass
    else:
        pass