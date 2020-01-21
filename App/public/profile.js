let bicycleID;
let gatewayID;
let status;
let startMarker;
let endMarker;
let trips;
let locations;
let map;
let trace;
let path = [];
let tripLocations = [];

$(document).ready(() => {
    $.get('https://www.freepublicbicycles.org/bicycles/get/all', (data) => {
        console.log(data);
        locations = data;
    });

    $.get('https://www.freepublicbicycles.org/user/status', (data) => {
        bicycleID = data.bicycle_id;
        gatewayID = data.gateway_id;
        status = data.status;

        if (status) {
            $("#bicycleLetGo").append('<button id="letgo" onClick="bicycleLetGo()">Let go of bicycle</button>');
        }
    });

    $.get('https://www.freepublicbicycles.org/user/trips/all', (data) => {
        trips = data;
        let id = 0;
        for (let i = 0; i < data.length; i++) {
            if (id != data[i].id) {
                $("#trips").append(`<li id="${data[i].id}">Trip Number: ${data[i].id}</li>`);
                id = data[i].id;
            }
        }

        id = 0;
        for (let j = 0; j < data.length; j++) {
            if (id != data[j].id) {
                $(`#${data[j].id}`).click((event) => {
                    path = [];
                    tripLocations = [];
                    let tripIDs = [];
                    let currentID = parseInt(event.target.id);
                    console.log(currentID);

                    for (let i = 0; i < trips.length; i++) {
                        if (trips[i].id == currentID) {
                            tripIDs.push(trips[i].locationID);
                        }
                    }

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

                    console.log(path);

                    startMarker = new google.maps.Marker({position: {lat: tripLocations[0].latitude, lng: tripLocations[0].longitude}, map: map});
                    endMarker = new google.maps.Marker({position: {lat: tripLocations[tripLocations.length - 1].latitude, lng: tripLocations[tripLocations.length - 1].longitude}, map: map});
                    trace = new google.maps.Polyline({
                        path: path,
                        geodesic: true,
                        strokeColor: '#FF0000',
                        strokeOpacity: 1.0,
                        strokeWeight: 2,
                        map: map
                    });
                });
            }
        }
    });
});

function bicycleLetGo() {
    $.post('https://www.freepublicbicycles.org/bicycles/letgo', {bicycle_id: bicycleID, gateway_id: gatewayID}, (data) => {
        $("#letgo").remove();
        location.reload();
    });
}

function initMap() {
    map = new google.maps.Map(document.getElementById('map'), { // Create map object
        center: {lat: 42.7254843, lng: 23.3056195}, // Set center point coordinates
        zoom: 16, // Set the initial zoom level of the map
        styles: [
          {elementType: 'geometry', stylers: [{color: '#242f3e'}]},
          {elementType: 'labels.text.stroke', stylers: [{color: '#242f3e'}]},
          {elementType: 'labels.text.fill', stylers: [{color: '#746855'}]},
          {
            featureType: 'administrative.locality',
            elementType: 'labels.text.fill',
            stylers: [{color: '#d59563'}]
          },
          {
            featureType: 'poi',
            elementType: 'labels.text.fill',
            stylers: [{color: '#d59563'}]
          },
          {
            featureType: 'poi.park',
            elementType: 'geometry',
            stylers: [{color: '#263c3f'}]
          },
          {
            featureType: 'poi.park',
            elementType: 'labels.text.fill',
            stylers: [{color: '#6b9a76'}]
          },
          {
            featureType: 'road',
            elementType: 'geometry',
            stylers: [{color: '#38414e'}]
          },
          {
            featureType: 'road',
            elementType: 'geometry.stroke',
            stylers: [{color: '#212a37'}]
          },
          {
            featureType: 'road',
            elementType: 'labels.text.fill',
            stylers: [{color: '#9ca5b3'}]
          },
          {
            featureType: 'road.highway',
            elementType: 'geometry',
            stylers: [{color: '#746855'}]
          },
          {
            featureType: 'road.highway',
            elementType: 'geometry.stroke',
            stylers: [{color: '#1f2835'}]
          },
          {
            featureType: 'road.highway',
            elementType: 'labels.text.fill',
            stylers: [{color: '#f3d19c'}]
          },
          {
            featureType: 'transit',
            elementType: 'geometry',
            stylers: [{color: '#2f3948'}]
          },
          {
            featureType: 'transit.station',
            elementType: 'labels.text.fill',
            stylers: [{color: '#d59563'}]
          },
          {
            featureType: 'water',
            elementType: 'geometry',
            stylers: [{color: '#17263c'}]
          },
          {
            featureType: 'water',
            elementType: 'labels.text.fill',
            stylers: [{color: '#515c6d'}]
          },
          {
            featureType: 'water',
            elementType: 'labels.text.stroke',
            stylers: [{color: '#17263c'}]
          }
        ]
    });
}