$(function() {
  $('form').on('submit', function(e) {
    e.preventDefault();
    e.stopPropagation();

    var name = $('input[name="name"]');
    var email = $('input[name="email"]');
    var telephone = $('input[name="telephone"]');
    var inputs= [name, email, telephone];
    hasError = false;

    for(var i = 0; i < 3; i++) {
      if(inputs[i].val() === "") {
        hasError = true;
        inputs[i].addClass('error');
      }
    }
    if(hasError) {
      $('.error-message').removeClass('hide');
      return;
    }

    $('.error-message').addClass('hide');
    $('.error').removeClass('error');

    successFn = function() {
      $('.callout').hide();
      $('.title-text').html("Congrats, help is on the way.<br />We'll contact you shortly.");
      $footer = $('.footer-image');
      $footer.appendTo($footer.parent().parent());
    };

    $.ajax({
      type: 'POST',
      url: '/signup',
      data: $('form').serialize(),
      success: successFn
    });
    $('input[type="submit"]').replaceWith('<img class="spinner" src="/ajaxSpinner.gif" />');
  });
});
