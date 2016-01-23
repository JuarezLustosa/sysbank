jQuery ->
  $("a[rel~=popover], .has-popover").popover()
  $("a[rel~=tooltip], .has-tooltip").tooltip()

#menu
htmlbodyHeightUpdate = ->
  height3 = $(window).height()
  height1 = $('.nav').height() + 50
  height2 = $('.main').height()
  if height2 > height3
    $('html').height Math.max(height1, height3, height2) + 10
    $('body').height Math.max(height1, height3, height2) + 10
  else
    $('html').height Math.max(height1, height3, height2)
    $('body').height Math.max(height1, height3, height2)
  return

$(document).ready ->
  htmlbodyHeightUpdate()
  $(window).resize ->
    htmlbodyHeightUpdate()
    return
  $(window).scroll ->
    height2 = $('.main').height()
    htmlbodyHeightUpdate()
    return
  return