document.addEventListener('turbo:load', function() {
    $('.select-component').on('change', function() {
      
        const selectedComponents = [];

        $('.select-component').each(function() {
          const component = $(this).val();
          if (component) { // Solo agregar si hay un valor seleccionado
            selectedComponents.push(component);
          }
        });
      
      
          const formData = $('#bike-order-form :not(input[name=_method])').serialize();
      
          $.post('/bike_orders/check_bike_order.js', formData)
            .done(function(response) {
              
            })
            .fail(function(xhr, status, error) {
              console.error('Error:', error);
              alert('Algo salió mal, recargue la página antes de intentarlo');
            });
        });
      
      $.ajaxSetup({
        headers: {
          'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
        }
    });
});

  