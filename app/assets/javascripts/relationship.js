$(document).on("turbolinks:load", function() {
  $("#follow_form").on("submit", function(e) {
    e.preventDefault();
    e.stopImmediatePropagation();
    if($("#submit").val() == "Follow") {
      $.ajax({
        type: "POST",
        url: $("#follow_form form").attr("action"),
        data: {followed_id: $("#followed_id").val()},
        dataType: "json",
        success: function(data, status, xhr) {
          $("#follow_form").html(data.partial);
          $("#followers").html(data.number);
        },
        error: function(status) {
          alert(I18n.t("js.error_follow"));
        }
      });
    }else{
      $.ajax({
        type: "DELETE",
        url: $("#follow_form form").attr("action"),
        data: {},
        dataType: "json",
        success: function(data, status, xhr) {
          $("#follow_form").html(data.partial);
          $("#followers").html(data.number);
        },
        error: function(status) {
          alert(I18n.t("js.error_follow"));
        }
      });
    }
  });
})
