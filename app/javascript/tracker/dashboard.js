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
        alert('Logged in Correctly');
      },
      error: function() {
        alert('Error logging in');
      },
      dataType: "json"
    });

    e.preventDefault();
  }


  $("#session-login").click( submitForm );
});