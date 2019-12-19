$(document).ready(function() {

  // $('.datepicker').datepicker();
  $('#all-users-report-filter-start-date').val("12/10/2019");
  $('#all-users-report-filter-end-date').val("01/31/2020");

  function renderAllUsersReport(columns, data) {

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

    $('#all-users-report-table th').remove();
    $('#all-users-report-table-header').append(tbl_header);
    $("#all-users-report-table > td").remove();
    $("#all-users-report-table-content").html(tbl_body);
  }

  function submitAllUsersReportFilter ( e ) {
    params = {
      "start_date": new Date($('#all-users-report-filter-start-date').val()),
      "end_date": new Date($('#all-users-report-filter-end-date').val()),
      "email": $('#all-users-report-filter-email').val(),
      "first_name": $('#all-users-report-filter-first-name').val(),
      "last_name": $('#all-users-report-filter-last-name').val(),
      "gender": $('#all-users-report-filter-gender option:selected').val()
    }

    $.ajax({
          type: "GET",
          url: "/api/v1/users/activity_report",
          contentType: "application/json",
          data: params,
          success: function (response){
            renderAllUsersReport(response.columns, response.data);
          },
          error: function(jqXHR, textStatus, errorThrown){
            alert(errorThrown);
          },
          dataType: "json"
        });
    e.preventDefault();
  }

   $('#all-users-report-link').click( submitAllUsersReportFilter )
   $('#all-users-report-filter-submit').click( submitAllUsersReportFilter )
});
