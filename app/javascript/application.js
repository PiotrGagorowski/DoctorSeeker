// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
//= require bootstrap
import "bootstrap"
import "@hotwired/turbo-rails"
import "controllers"

import "trix"
import "@rails/actiontext"
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require turbolinks
//= require jquery-ui
//= require jquery

document.addEventListener("DOMContentLoaded", () => {
    $('.dropdown-toggle').dropdown();
  });
  
document.addEventListener('turbolinks:load', function() {
    // Znajdź wszystkie elementy z atrybutem data-bs-toggle w navbarze
    var bootstrapDropdowns = document.querySelectorAll('.navbar [data-bs-toggle="dropdown"]');

    // Dla każdego elementu dodajmy nasłuchiwanie na kliknięcie
    bootstrapDropdowns.forEach(function(dropdown) {
        dropdown.addEventListener('click', function(event) {
            // Sprawdź, czy menu jest otwarte
            var isOpen = dropdown.classList.contains('show');

            // Jeśli menu jest otwarte, zamknij je
            if (isOpen) {
                dropdown.classList.remove('show');
            } else {
                // W przeciwnym razie otwórz je
                dropdown.classList.add('show');
            }

            // Zatrzymaj domyślną akcję linku
            event.preventDefault();

            // Usuń hash z URL, jeśli istnieje
            if (window.location.hash) {
                history.replaceState(null, null, window.location.pathname);
            }
        });
    });

    // Znajdź wszystkie elementy o klasie 'dropdown-menu'
    var dropdownMenus = document.querySelectorAll('.dropdown-menu');

    // Dla każdego elementu dodajmy nasłuchiwanie na kliknięcie
    dropdownMenus.forEach(function(menu) {
        menu.addEventListener('click', function() {
            // Odśwież stronę
            location.reload();
        });
    });
});



  
  