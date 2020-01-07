$(document).ready(function() {
    $('#home').attr('href', extractbase() + '/home');
    $('#map').attr('href', extractbase() + '/map');
    $('#profile').attr('href', extractbase() + '/profile');
    
    $('#logout').click(function() {
        let url = window.location.href;
        let base = url.substring(0, url.lastIndexOf('/'));
        url = base + '/logout';

        $.get(url, function(data) {
            window.location.href = base + '/login';
         });
    });
});

function extractbase() {
    let url = window.location.href;
    let base = url.substring(0, url.lastIndexOf('/'));
    return base;
}
