$(document).ready(() => {
    $('#home').attr('href','https://www.freepublicbicycles.org/home');
    $('#map').attr('href', 'https://www.freepublicbicycles.org/map');
    $('#Map').attr('href', 'https://www.freepublicbicycles.org/map');
    $('#profile').attr('href', 'https://www.freepublicbicycles.org/profile');
    
    $('#logout').click(() => {
        $.get('https://www.freepublicbicycles.org/logout', (data) => {
            window.location.href = 'https://www.freepublicbicycles.org/login';
         });
    });
});
