$(document).ready(function() {

  function renderUserReport(columns, data) {

    var tbl_header = "";
    $.each(columns, function(i, column) {
            tbl_header += "<th>"+column+"</th>";
    });


    var tbl_body = "";
    $.each(data, function() {
        var tbl_row = "";
        $.each(this, function(k , v) {
            tbl_row += "<td>"+v+"</td>";
        })
        tbl_body += "<tr>"+tbl_row+"</tr>";
    });

    $('#user-report-table th').remove();
    $('#user-report-table-header').append(tbl_header);
    $("#user-report-table > td").remove();
    $("#user-report-table-content").html(tbl_body);
  }

  function requestUserReport ( e ) {
    url = `/api/v1/users/${$('#user_id').val()}/activity_report`

    $.ajax({
          type: "GET",
          url: url,
          contentType: "application/json",
          success: function (response){
            renderUserReport(response.columns, response.data);
          },
          error: function(jqXHR, textStatus, errorThrown){
            alert(errorThrown);
          },
          dataType: "json"
        });
    e.preventDefault();
  }

   $('#history-link').click( requestUserReport )
});
