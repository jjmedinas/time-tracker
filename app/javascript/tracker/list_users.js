$(document).ready(function() {

  function renderListUsers(data) {

    var tbl_body = "";
    $.each(data, function() {
        var tbl_row = "";
        $.each(this, function(k , v) {
            tbl_row += "<td>"+v+"</td>";
        })
        tbl_body += "<tr>"+tbl_row+"</tr>";
    });

    $("#list-users-table > td").remove();
    $("#list-users-table-body").html(tbl_body);
  }

  function submitListUsersFilter ( e ) {
    params = {
      "email": $('#list-users-filter-email').val(),
      "first_name": $('#list-users-filter-first-name').val(),
      "last_name": $('#list-users-filter-last-name').val(),
      "gender": $('#list-users-filter-gender').val()
    }

    $.ajax({
          type: "GET",
          url: "/api/v1/users/",
          contentType: "application/json",
          data: params,
          success: function (response){
            renderListUsers(response);
          },
          error: function(jqXHR, textStatus, errorThrown){
            alert(errorThrown);
          },
          dataType: "json"
        });
    e.preventDefault();
  }

   $('#list-users-link').click( submitListUsersFilter )
   $('#list-users-filter-submit').click( submitListUsersFilter )
});
