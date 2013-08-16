$(function() {
  $('form').on('submit', function(e) {
    e.preventDefault();
    e.stopPropagation();
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
    $('input[type="submit"]').replaceWith('<img class="spinner" src="/ajaxSpinner.gif" />')
  });
});
