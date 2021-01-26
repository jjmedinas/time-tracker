$(document).ready(function() {


  function trackClick ( e ) {
    url = `/api/v1/clicks/`;
    path = window.location.pathname;

    $.ajax({
      type: "POST",
      url: url,
      data: JSON.stringify({
        clicks: { 
          path: path
        }
      }),
      contentType: "application/json",
      success: function (){
      },
      error: function(){
      },
      dataType: "json"
    });

    e.preventDefault();
  }

  $('#logo').click( trackClick )
});
