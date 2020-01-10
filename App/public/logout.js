$(document).ready(() => {
    $('#home').attr('href','https://www.freepublicbicycles.org/home');
    $('#map').attr('href', 'https://www.freepublicbicycles.org/map');
    $('#Map').attr('href', 'https://www.freepublicbicycles.org/map');
    $('#profile').attr('href', 'https://www.freepublicbicycles.org/profile');
    
    $('#logout').click(() => {
        let url = window.location.href;
        let base = url.substring(0, url.lastIndexOf('/'));
        url = base + '/logout';

        $.get(url, (data) => {
            window.location.href = base + '/login';
         });
    });
});
