let map;
let coords = new Array();
let markers = new Array();
let userLatitude;
let userLongitude;

function initMap() {
    map = new google.maps.Map(document.getElementById('map'), {
        center: {lat: 42.7289807, lng: 23.2992328},
        zoom: 8
    });

    updateMarkers();
    setTimeout(() => {
        createMarkers();        
    }, 500);

    //marker = new google.maps.Marker({position: {lat: 42.7289807, lng: 23.2992328}, map: map});
}

function updateMarkers() {
    $.get(extractBase() + '/bicycles/get/free', function(data) {
        for (let i = 0; i < data.length; i++) {
            coords.push({
                lat: data[i].longitude,
                lng: data[i].latitude,
                bicycle_id: data[i].bicycle_id,
                gateway_id: data[i].gateway_id
            });
        }

        console.log(coords.length);
    });
}

function extractBase() {
    let url = window.location.href;
    let base = url.substring(0, url.lastIndexOf('/'));
    return base;
}

function createMarkers() {
    for (let i = 0; i < coords.length; i++) {
        marker = new google.maps.Marker({position: {lat: coords[i].lat, lng: coords[i].lng}, map: map, bicycle_id: coords[i]});
        markers.push(marker);
    
        let infoWindow = new google.maps.InfoWindow({
            //content: "bateriq, adres, kopche za naemane"
            content: "<div>" + "Bicycle ID: " + coords[i].bicycle_id + "<br> Gateway ID: " + coords[i].gateway_id + "<br><input type='submit' value='Rent' onclick='rentBicycle()'></div>"
        });

        google.maps.event.addListener(markers[i], 'click', () => {
            infoWindow.open(map, markers[i]);
        });
    }

    console.log(coords.length);
}

function rentBicycle() {
    $("div")

    // $.post(extractBase + '/bicycles/rent', bicycle_id: , (data) => {

    // });
}