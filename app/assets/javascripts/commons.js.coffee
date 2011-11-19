$(document).ready ->
  $("#messagebox_wrapper").fadeIn(1700);  
  $("#messagebox").delay(10000).fadeOut(1200);
  $(".dismiss > a").click -> $("#messagebox").fadeOut(1200);