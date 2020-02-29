let bicycleID; // Current bicycle_id rented by the user
let gatewayID; // Gateway to access bicycle
let status; // Status of the current bicycle
let startMarker; // Marker indicating the start position of the current trip
let endMarker; // Marker indicating the end position of the current trip
let trips; // Trips array
let locations; // Location of all free bicycles
let map; // Google Maps map object
let trace; // Trace object created by the position of all points from the current trip
let path = []; // Positions from the current trip
let id = 0;
let currentID;
let tripIDs = [];
let tripLocations = []; // Locations from all trips of the user

$(document).ready(() => { // Wait for page to load
    $.get('https://www.freepublicbicycles.org/bicycles/get/all', (data) => { // Get all location of bicycles
        locations = data;
    });

    $.get('https://www.freepublicbicycles.org/user/status', (data) => { // Get user status
        bicycleID = data.bicycle_id;
        gatewayID = data.gateway_id;
        status = data.status;
        console.log(status);

        if (status) { // Chech if user has rented a bicycle
            $("#bicycleLetGo").append('<button id="letgo" onClick="bicycleLetGo()">Let go of bicycle</button>'); // Add button for letting go of bicycle
        }
    });

    $.get('https://www.freepublicbicycles.org/user/trips/all', (data) => { // Get all trips of user
        trips = data;
        setTrips(trips);
        setEventListeners(trips);
    });
});

function bicycleLetGo() { // Let go of bicycle
    $.post('https://www.freepublicbicycles.org/bicycles/letgo', {bicycle_id: bicycleID, gateway_id: gatewayID}, (data) => { // Send post request to API
        $("#letgo").remove(); // Remove bicycle let go button
        location.reload(); // Reload page
    });
}

function initMap() { // Google maps API map setup
    map = new google.maps.Map(document.getElementById('map'), { // Create map object
        center: {lat: 42.7254843, lng: 23.3056195}, // Set center point coordinates
        zoom: 16, // Set the initial zoom level of the map
        styles: styles
    });
}

function setTripIDs() { // Get ids of all trips
    for (let i = 0; i < trips.length; i++) {
        if (trips[i].id == currentID) {
            tripIDs.push(trips[i].locationID);
        }
    }
}

function setTripLocations() { // Get locations of all unique trips
    for (let i = 0; i < tripIDs.length; i++) {
        for (let j = 0; j < locations.length; j++) {
            if (tripIDs[i] == locations[j].id) {
                path.push({
                    lat: locations[j].latitude,
                    lng: locations[j].longitude
                });
                tripLocations.push(locations[j]);
            }
        }
    }
}

function createMarkers() { // Create start marker, end marker and trace in between
    if (startMarker) { // Check if a marker already exists
        startMarker.setMap(null); // Delete start marker
        endMarker.setMap(null); // Delete end marker
        trace.setMap(null); // Delete trace
    }

    startMarker = new google.maps.Marker({position: {lat: tripLocations[0].latitude, lng: tripLocations[0].longitude}, map: map}); // Create start marker
    endMarker = new google.maps.Marker({position: {lat: tripLocations[tripLocations.length - 1].latitude, lng: tripLocations[tripLocations.length - 1].longitude}, map: map}); // Create end marker 
    trace = new google.maps.Polyline({ // Create trace
        path: path,
        geodesic: true,
        strokeColor: '#FF0000',
        strokeOpacity: 1.0,
        strokeWeight: 2,
        map: map
    });
}

function setTrips(data) { // Set HTML trips list items properties
    let j = 0;
    for (let i = 0; i < data.length; i++) {
        if (id != data[i].id) {
            j++;
            $("#trips").append(`<li id="${data[i].id}">Trip Number: ${j}</li>`); // Add new trip button
            id = data[i].id;
        }
    }
}

function setEventListeners(data) { // Set HTML trips list items mouse click event listeners
    id = 0;
    for (let j = 0; j < data.length; j++) {
        if (id != data[j].id) {
            $(`#${data[j].id}`).click((event) => { // Add click event listener for each button
                path = [];
                tripLocations = [];
                tripIDs = [];
                currentID = parseInt(event.target.id);

                setTripIDs();
                setTripLocations();
                createMarkers();
            });
        }
    }
}