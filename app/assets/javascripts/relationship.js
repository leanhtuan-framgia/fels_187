$(document).ready(function() {
  $("#follow_form").submit(function(e) {
    if($("#submit").val() == "Follow") {
      $.ajax({
        type: "POST",
        url: $("#follow_form form").attr("action"),
        data: {followed_id: $("#followed_id").val()},
        dataType: "json",
        success: function(data, status, xhr) {
          $("#follow_form").html(data.partial);
          $("#followers").html(data.number);
          return false;
        },
        error: function(status) {
          return false;
        }
      });
    }else {
      $.ajax({
        type: "DELETE",
        url: $("#follow_form form").attr("action"),
        data: {},
        dataType: "json",
        success: function(data, status, xhr) {
          $("#follow_form").html(data.partial);
          $("#followers").html(data.number);
          return false;
        },
        error: function(status) {
          return false;
        }
      });
    }
  });
})
