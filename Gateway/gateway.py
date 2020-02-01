import PyLora # Import LoRa library
import time # Import time library
import requests # Import HTTP requests library
from datetime import datetime # Import date and time library

global gateway_id # Create the id of the current gateway 
gateway_id = 101 # Set the id of the gateway

def check_packet(packet): # Checks if the received LoRa packet is button click
    return "button" in packet # Check if the packet containts button message

PyLora.init() # Initialize LoRa module
PyLora.set_frequency(868000000) # Set the operating frequency of the LoRa module
PyLora.enable_crc() # Enable CRC on the LoRa module

print("Gateway listening...")

while True:
    PyLora.receive() # Listen for incoming packets
    while not PyLora.packet_available():
        time.sleep(0)
    rec = PyLora.receive_packet() # Read incoming packets
    now = datetime.now().strftime('%Y-%m-%d %H:%M:%S'); # Get time of reception
    print now
    info = rec.split(',') # Separate message
    bicycle_id = info[0].strip().decode('utf-8') # Get the bicycle_id

    if (check_packet(rec)): # Check if the message is a button message
        print "tuk"
        PyLora.send_packet('{}, button_ack'.format(bicycle_id)) # Reply with acknowldgement
        req = requests.post('https://www.freepublicbicycles.org/bicycles/rent', verify = False, json = { # Make a rent request to the FreePublicBicycles API
            "bicycle_id": bicycle_id, # Set data for the reuest
            "gateway_id": gateway_id
        })
    else:
        try:
            latitude = info[1].strip().decode('utf-8') # Extract position info from packet
            longitude = info[2].strip().decode('utf-8')
            battery = info[3].strip().decode('utf-8')
            req = requests.put('https://www.freepublicbicycles.org/locations/add', verify = False, json = { # Make a request to the API to update the bicycle's info
                "bicycle_id": bicycle_id, # Set data for the request
                "gateway_id": gateway_id,
                "latitude": latitude,
                "longitude": longitude,
                "timestamp": now,
                "battery": battery
            })
        except:
            print 'Request Failed'

    print 'Packet received: {}'.format(rec)