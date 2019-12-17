$(document).ready(function() {

  function checkIn ( e ) {
    user_id = $('#user_id').val();
    url = `/api/v1/users/${user_id}/activity_logs/current/check_in`;

    $.ajax({
      type: "POST",
      url: url,
      contentType: "application/json",
      success: function (){
        md.showCheckedInNotification('top', 'center');
        $('#check-in-button').attr("disabled", true);
      },
      error: function(){
        if (!$('#check-in-button').disabled) {
          md.showGeneralErrorNotification('top','center');
        }
      },
      dataType: "json"
    });

    e.preventDefault();
  }

  function checkOut ( e ) {
    user_id = $('#user_id').val();
    url = `/api/v1/users/${user_id}/activity_logs/current/check_out`;

    $.ajax({
      type: "POST",
      url: url,
      contentType: "application/json",
      success: function (){
        md.showGeneralSuccessNotification('top', 'center', 'Checked out correctly!');
        $('#check-out-button').attr("disabled", true);
      },
      error: function(){
        if (!$('#check-out-button').disabled) {
          md.showGeneralErrorNotification('top','center');
        }
      },
      dataType: "json"
    });

    e.preventDefault();
  }
  $('#check-in-button').click( checkIn )
  $('#check-out-button').click( checkOut )
});