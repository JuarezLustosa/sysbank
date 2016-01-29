set_close_time = (div) ->
  setInterval (->
    $(div).fadeOut 'slow'
    return
  ), 8000
  return

set_class_alert = (box, err) ->
  if err
    box.addClass 'alert-danger'
  else
    box.removeClass 'alert-danger'
  return

(($) ->
  $.extend flash: (message, err) ->
    set_close_time '.bootstrap-flash'
    div = '<div class="bootstrap-flash alert alert-success" style=top:10px;right190%;width:90%;float:left;z-index:1500;"><a class="close" href="#" onclick="$(this).parent().hide();return false;">&times;</a><h3 style="margin:0!important"></h3></div>'
    $('#flash').prepend div
    box = $('.bootstrap-flash')
    set_class_alert box, err
    box.find('h3').html message
    box.show()
    return
  return
) jQuery
