import PyLora # Import LoRa library
import time # Import time library
import requests # Import HTTP requests library
from requests.packages.urllib3.exceptions import InsecureRequestWarning
from datetime import datetime # Import date and time library
import re # Import regular expressions library

# Disable warning for HTTP requests using SSL
requests.packages.urllib3.disable_warnings(InsecureRequestWarning)

global gateway_id # Create the id of the current gateway 
gateway_id = 101 # Set the id of the gateway

# Checks if the received LoRa packet is button click
def check_packet(packet): 
    # Check if the packet containts button message
    return "b" in packet 

# Checks if packet is valid 
def validate_packet(packet): 
    # Allowed symbols: a-z, A-Z, 0-9, ',', '.'
    rx = "^[a-zA-Z0-9., ]" 
    return True if re.search(rx, packet) else False

# Main packet handling
def handle_packet(packet): 
    now = datetime.now().strftime('%Y-%m-%d %H:%M:%S'); # Get time of reception
    print now
    info = packet.split(',') # Separate message
    bicycle_id = info[0].strip().decode('utf-8') # Get the bicycle_id

    # Check if the message is a button message
    if (check_packet(packet)): 
        # Make a rent request to the FreePublicBicycles API
        rentURL = 'https://www.freepublicbicycles.org/bicycles/rent'
        req = requests.post(rentURL, verify = False, json = { 
            "bicycle_id": bicycle_id, # Set data for the reuest
            "gateway_id": gateway_id
        })
    else:
        try:
            # Extract position info from packet
            latitude = info[1].strip().decode('utf-8') 
            longitude = info[2].strip().decode('utf-8')
            battery = info[3].strip().decode('utf-8')
            # Make a request to the API to update the bicycle's info
            locationsURL = 'https://www.freepublicbicycles.org/locations/add'
            req = requests.put(locationsURL, verify = False, json = { 
                "bicycle_id": bicycle_id, # Set data for the request
                "gateway_id": gateway_id,
                "latitude": latitude,
                "longitude": longitude,
                "timestamp": now,
                "battery": battery
            })
        except:
            print 'Request Failed'

    print 'Packet received: {}'.format(packet)

# Execute initial cofnfiguration
def setup(): 
    # Initialize LoRa module
    PyLora.init() 
    # Set the operating frequency of the LoRa module
    PyLora.set_frequency(868000000) 
    # Enable CRC on the LoRa module
    PyLora.enable_crc() 
    print("Gateway listening...")

# Execute main logic
def main():  
    # Listen for incoming packets
    while True:
        PyLora.receive() 
        while not PyLora.packet_available():
            time.sleep(0)
        # Read incoming packets
        rec = PyLora.receive_packet() 
        try:
            if (validate_packet(rec)):
                handle_packet(rec)
        except:
            print 'Invalid packet'

setup() # Execute setup method
main() # Execute main method