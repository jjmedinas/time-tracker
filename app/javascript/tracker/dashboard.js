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
      error: md.showLoginErrorNotification('top','center'),
      dataType: "json"
    });

    e.preventDefault();
  }

  function logout( e ) {
    $.ajax({
      type: "DELETE",
      url: "/api/v1/sessions",
      contentType: "application/json",
      success: function() {
        window.location = '/'
      },
      error: function() {
        alert('Error logging out.');
      },
      dataType: "json"
    });

    e.preventDefault();
  }

  function showUserProfile( e ){
    e.preventDefault();
    $('#user-profile-content').removeClass("hidden");
    $('#list-users-content').addClass("hidden");
    $('#all-users-report-content').addClass("hidden");
    $('#track-time-content').addClass("hidden");
    $('#history-content').addClass("hidden");

    $("#user-profile-nav").addClass("active")
    $("#list-users-nav").removeClass("active")
    $("#all-users-report-nav").removeClass("active")
    $('#history-nav').removeClass("active")
    $('#track-time-nav').removeClass("active")
  }

  function showUsersList( e ){
    e.preventDefault();
    $('#list-users-content').removeClass("hidden");
    $('#user-profile-content').addClass("hidden");
    $('#all-users-report-content').addClass("hidden");

    $("#list-users-nav").addClass("active")
    $("#user-profile-nav").removeClass("active")
    $("#all-users-report-nav").removeClass("active")
  }

  function showAllUsersReport( e ){
    e.preventDefault();
    $('#all-users-report-content').removeClass("hidden");
    $('#user-profile-content').addClass("hidden");
    $('#list-users-content').addClass("hidden");

    $("#all-users-report-nav").addClass("active")
    $("#user-profile-nav").removeClass("active")
    $("#list-users-nav").removeClass("active")
  }

  function showTrackTime( e ){
    e.preventDefault();
    $('#track-time-content').removeClass("hidden");
    $('#user-profile-content').addClass("hidden");
    $('#history-content').addClass("hidden");

    $('#track-time-nav').addClass("active")
    $('#user-profile-nav').removeClass("active")
    $('#history-nav').removeClass("active")
  }

  function showHistory( e ){
    e.preventDefault();
    $('#history-content').removeClass("hidden");
    $('#user-profile-content').addClass("hidden");
    $('#track-time-content').addClass("hidden");

    $('#history-nav').addClass("active")
    $('#user-profile-nav').removeClass("active")
    $('#track-time-nav').removeClass("active")
  }


  $("#session-login").click( submitForm );
  $("#session-logout").click( logout );

  $("#user-profile-link").click( showUserProfile );
  $("#list-users-link").click( showUsersList );
  $("#all-users-report-link").click( showAllUsersReport );
  $("#track-time-link").click( showTrackTime );
  $("#history-link").click( showHistory );
});
