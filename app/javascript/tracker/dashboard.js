$(document).ready(function() {

  function submitForm ( e ) {
    data = {
      "session": {
        "email": $('#session-email').val(),
        "password": $('#session-password').val()
      }
    };

    $.ajax({
      type: "POST",
      url: "/api/v1/sessions",
      contentType: "application/json",
      data: JSON.stringify(data),
      processData: false,
      success: function() {
        window.location = '/dashboard'
      },
      error: function() {
        alert('Error logging in');
      },
      dataType: "json"
    });

    e.preventDefault();
  }

  $("#session-login").click( submitForm );

  function logout( e ) {
    $.ajax({
      type: "DELETE",
      url: "/api/v1/sessions",
      contentType: "application/json",
      success: function() {
        window.location = '/'
      },
      error: function() {
        alert('Error loggin out');
      },
      dataType: "json"
    });

    e.preventDefault();
  }

  $("#session-logout").click( logout );
});
