$(document).ready(() => { // Wait for page to load
    $('#home').attr('href','https://www.freepublicbicycles.org/home'); // Set hrefs for navbar
    $('#map').attr('href', 'https://www.freepublicbicycles.org/map');
    $('#Map').attr('href', 'https://www.freepublicbicycles.org/map');
    $('#profile').attr('href', 'https://www.freepublicbicycles.org/profile');
    
    $('#logout').click(() => { // Logout button event listener
        $.get('https://www.freepublicbicycles.org/logout', (data) => { // Make a get request for logout

        });
    });
});
