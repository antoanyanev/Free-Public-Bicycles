$(document).ready(() => {
    $('#home').attr('href', extractBase() + '/home');
    $('#map').attr('href', extractBase() + '/map');
    $('#profile').attr('href', extractBase() + '/profile');
    
    $('#logout').click(() => {
        let url = window.location.href;
        let base = url.substring(0, url.lastIndexOf('/'));
        url = base + '/logout';

        $.get(url, (data) => {
            window.location.href = base + '/login';
         });
    });
});

function extractBase() {
    let url = window.location.href;
    let base = url.substring(0, url.lastIndexOf('/'));
    return base;
}
