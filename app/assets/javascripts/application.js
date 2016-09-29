// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require jquery.countdown
//= require countdown
//= require i18n/translations
//= require lesson
//= require_tree .

function remove_fields(link) {
  $(link).prev('input[type=hidden]').val('1');
  $(link).closest('.fields').hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp('new_' + association, 'g')
  $(link).before(content.replace(regexp, new_id));
}


$(document).on('turbolinks:load', function(){
  if($('.question_type').val() == 'text'){
    $('.correct-choose').hide();
    $('.add_answer').hide();
  }
  else if($('.question_type').val() == 'single_choice'){
    $('.correct-choose').show();
    $('.add_answer').show();
    $('.answer').on('change', 'input[type=checkbox]',function(){
      $('.answer').find('input[type=checkbox]').not(this).attr('checked', false);
    });
  }
  $('.question_type').on('click', function(){
    var type = $('.question_type').val();
    if(type == 'text'){
      $('.correct-choose').hide();
      $('.add_answer').hide();
      $('.answer').find('input[type=checkbox]').attr('checked', false);
    }
    else if(type == 'single_choice'){
      $('.correct-choose').show();
      $('.add_answer').show();
      $('.answer').on('change', 'input[type=checkbox]',function(){
        $('.answer').find('input[type=checkbox]').not(this).attr('checked', false);
      });
    }
    else{
      $('.correct-choose').show();
      $('.add_answer').show();
    }
  });
});
