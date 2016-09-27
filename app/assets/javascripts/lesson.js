$(document).on("turbolinks:load", function() {
  $(".lesson_question").hide();
  $(".lesson_question:first").show();
  if(parseInt($('#remaining_time').val())>0) {
    $(".pagination li:first").nextAll(".pagination li").addClass("disabled");
    $(".pagination li:first").addClass("active");
  }else {
    $(".pagination li:first").addClass("active");
  }

  $("#next").click(function() {
    if($(".lesson_question:visible")
      .nextAll(".lesson_question").first().length) {
      var number = $(".lesson_question").index($(".lesson_question:visible"));
      $(".lesson_question:visible").nextAll(".lesson_question").first()
        .show().prevAll(".lesson_question").first().hide();
      $(".pagination li .active").nextAll(".pagination li")
        .first().removeClass("disabled");
      $(".pagination li").removeClass("active");
      $(".pagination li").eq(number+1).removeClass("disabled")
        .addClass("active");
    }
    return false;
  });

  $("#prev").click(function() {
    if($(".lesson_question:visible")
      .prevAll(".lesson_question").first().length) {
      var number = $(".lesson_question").index($(".lesson_question:visible"));
      $(".lesson_question:visible").prevAll(".lesson_question").first()
        .show().nextAll(".lesson_question").first().hide();
      $(".pagination li").removeClass("active");
      $(".pagination li").eq(number-1).removeClass("disabled")
        .addClass("active");
    }
    return false;
  });

  $(".pagination li a").on("click", function() {
    if($(event.target).parent().hasClass("disabled") == false){
      var x = parseInt($(event.target).text());
      $(".lesson_question:visible").hide();
      $(".lesson_question").eq(x-1).show();
      $(".pagination li").removeClass("active");
      $(".pagination li").eq(x-1).addClass("active");
    }
    return false;
  });

  $(".question_answer").on("click", function(event) {
    if((parseInt($('#remaining_time').val())>0) && ($(event.target).is(":checkbox")!= true)) {
      if($(event.target).find("input:checkbox").is(":checked")){
        $(event.target).find("input:checkbox").prop("checked", false);
      }
      else {
        $(event.target).find("input:checkbox").prop("checked", true);
      }
      return false;
    }
  });
});
