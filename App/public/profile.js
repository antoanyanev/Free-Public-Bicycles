let bicycleID;
let gatewayID;
let status;

$(document).ready(() =>{
    $.get('https://www.freepublicbicycles.org/user/status', (data) => {
        bicycleID = data.bicycle_id;
        gatewayID = data.gateway_id;
        status = data.status;

        if (status) {
            $("#bicycleLetGo").append('<button id="letgo" onClick="bicycleLetGo()">Let go of bicycle</button>');
        }
    });
});

function bicycleLetGo() {
    $.post('https://www.freepublicbicycles.org/bicycles/letgo', {bicycle_id: bicycleID, gateway_id: gatewayID}, (data) => {
        $("#letgo").remove();
    });
}