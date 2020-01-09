let map; // Map object
let coords = new Array(); // Stores data of all free bicycles
let markers = new Array(); // Stores markers that correspond to the data objects in coords
let userMarker; // Marker that indicates the current posiotion of the user
let markerRefreshInterval = 10000; // Interval between each marker refresh

const icons = { // Set of image urls; All of them respond to different battery percantage levels:
    battery_red: './images/marker_red.png', // 30 - 40%
    battery_brown: './images/marker_brown.png', // 40 - 65%
    battery_yellow: './images/marker_yellow.png', // 65 - 85%
    battery_green: './images/marker_green.png' // 85 - 100%
};

function initMap() {
    map = new google.maps.Map(document.getElementById('map'), { // Create map object
        center: {lat: 42.7254843, lng: 23.3056195}, // Set center point coordinates
        zoom: 16 // Set the initial zoom level of the map
    });

    createButtons(); // Create custom map buttons
    userMarker = new google.maps.Marker({position: {lat: 42.7254843, lng: 23.3056195}, map: map}); // Create initial user marker
    updateMarkers(); // Update & Create  Markers 
    refreshMarkers(); // 
}

function updateMarkers() { // GETs free bicycles' data and creates new markerss
    $.get(extractBase() + '/bicycles/get/free', function(data) { // Make a GET request for all free bicycles' data
        for (let i = 0; i < data.length; i++) {
            coords.push({ // Append a data object for each bicycle into coords
                lat: data[i].longitude, // Latitude
                lng: data[i].latitude, // Longitude
                bicycle_id: data[i].bicycle_id, // Bicycle ID
                gateway_id: data[i].gateway_id, // gateway ID
                battery: data[i].battery // Battery Level
            });
        }
    }).then(() => { 
        createMarkers(); // Create markers based on data inserted into coords
    });
}

function extractBase() { // Extract the base URL
    let url = window.location.href; // Get current URL
    let base = url.substring(0, url.lastIndexOf('/')); // Substring the domain
    return base;
}

function createMarkers() { // Create markers objects based on coords data
    let address; // Stores the address of each bicycle
    let icon; // Store the icon url of each bicycle

    for (let i = 0; i < coords.length; i++) { // Choose an icon for each marker
        let battery = coords[i].battery;
        icon = {
            url: chooseIcon(battery),
            scaledSize: new google.maps.Size(60, 80), // Rescale icon
            origin: new google.maps.Point(0, 0), // Set origin point
            anchor: new google.maps.Point(30, 80) // Set anchor point
        }

        marker = new google.maps.Marker({position: {lat: coords[i].lat, lng: coords[i].lng}, map: map}); // Create map object
        marker.setIcon(icon); // Change default icon
        markers.push(marker); // Append marker object to markers array

        // Make a GET request to Google Geocoding API
        $.get(`https://maps.googleapis.com/maps/api/geocode/json?latlng=${coords[i].lat},${coords[i].lng}&key=AIzaSyDZ0puiDWzf9zJOZVaNtg6chU6P6c_XeUY`, (data) => {
            address = data.results[0].formatted_address; // Extact address of each bicycle from GET response
        }).then(() => {
            let infoWindow = new google.maps.InfoWindow({ // Create a pop up window for each marker
                //content: "bateriq, adres, kopche za naemane"
                content: "<div>" + "Address: " + address + // Set HTML content of pop up
                         "<br> Battery: " + battery + "%" +
                         "<br> Bicycle ID: " + coords[i].bicycle_id +
                         "<br> Gateway ID: " + coords[i].gateway_id + 
                         "<br> <input type='submit' value='Rent' onclick='rentBicycle()'></div>" // Assign a callback function to rent button
            });

            google.maps.event.addListener(markers[i], 'click', () => { // Bind event listener for click on each marker
                infoWindow.open(map, markers[i]);  // Open pop up
            });
        });
    }
}

function chooseIcon(battery) { // Choose an appropriate icon based on the bicycle's battery level
    let icon;

    if (battery <= 40) {
        icon = icons.battery_red;
    } else if (battery > 40 && battery <= 65) {
        icon = icons.battery_brown;
    } else if (battery > 65 && battery <= 85) {
        icon = icons.battery_yellow;
    } else if (battery > 85) {
        icon = icons.battery_green;
    }

    return icon;
}

function CenterControl(controlDiv, map) { // Add styles and event listeners
    // Set CSS for the control border.
    var controlUI = document.createElement('div');
    controlUI.style.backgroundColor = '#fff';
    controlUI.style.border = '2px solid #fff';
    controlUI.style.borderRadius = '3px';
    controlUI.style.boxShadow = '0 2px 6px rgba(0,0,0,.3)';
    controlUI.style.cursor = 'pointer';
    controlUI.style.marginBottom = '22px';
    controlUI.style.textAlign = 'center';
    controlUI.style.marginTop = '10px';
    controlUI.title = 'Click to recenter the map';
    controlDiv.appendChild(controlUI);

    // Set CSS for the control interior.
    var controlText = document.createElement('div');
    controlText.style.color = 'rgb(25,25,25)';
    controlText.style.fontFamily = 'Roboto,Arial,sans-serif';
    controlText.style.fontSize = '16px';
    controlText.style.lineHeight = '38px';
    controlText.style.paddingLeft = '5px';
    controlText.style.paddingRight = '5px';
    controlText.innerHTML = 'Center Map';
    controlUI.appendChild(controlText);

    // Setup the click event listeners
    controlUI.addEventListener('click', function() {
      map.setCenter(userMarker.getPosition());
    });
}

function UserLocationControl(controlDiv, map) { // Add styles and event listeners
    // Set CSS for the control border.
    var controlUI = document.createElement('div');
    controlUI.style.backgroundColor = '#fff';
    controlUI.style.border = '2px solid #fff';
    controlUI.style.borderRadius = '3px';
    controlUI.style.boxShadow = '0 2px 6px rgba(0,0,0,.3)';
    controlUI.style.cursor = 'pointer';
    controlUI.style.marginBottom = '22px';
    controlUI.style.textAlign = 'center';
    controlUI.style.marginTop = '10px';
    controlUI.title = 'Click to refresh user marker position';
    controlDiv.appendChild(controlUI);

    // Set CSS for the control interior.
    var controlText = document.createElement('div');
    controlText.style.color = 'rgb(25,25,25)';
    controlText.style.fontFamily = 'Roboto,Arial,sans-serif';
    controlText.style.fontSize = '16px';
    controlText.style.lineHeight = '38px';
    controlText.style.paddingLeft = '5px';
    controlText.style.paddingRight = '5px';
    controlText.innerHTML = 'User Location';
    controlUI.appendChild(controlText);

    // Setup the click event listeners
    controlUI.addEventListener('click', function() {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition((position) => {
                userMarker.setMap(null);
                userMarker = new google.maps.Marker({position: {lat: position.coords.latitude, lng: position.coords.longitude}, map: map});
            });
        }
    });
}

function createButtons() { // Create custom map buttons
    let centerControlDiv = document.createElement('div'); // Create a html element to store the Center button
    let centerControl = new CenterControl(centerControlDiv, map); // Add styles and event listeners
    let userLocationControlDiv = document.createElement('div'); // Create a html element to store the UserPosition button
    let userLocationControl = new UserLocationControl(userLocationControlDiv, map); // Add styles and event listeners

    centerControlDiv.index = 1;
    userLocationControlDiv.index = 2;
    map.controls[google.maps.ControlPosition.TOP_LEFT].push(centerControlDiv); // Append Center button to map
    map.controls[google.maps.ControlPosition.TOP_LEFT].push(userLocationControlDiv); // Append UserPosition to map
}

function refreshMarkers() { // Create custom map buttons
    setInterval(() => { // Executes callback funcction every ten seconds
        coords.length = new Array(); // Empty array with free bicycles data
        for (let i = 0; i < markers.length; i++) {
            markers[i].setMap(null); // Remove all markers from markers array
        }
        markers.length = new Array(); // Initialize markers array
        updateMarkers(); // Update markers
    }, markerRefreshInterval);
}