$ ->

  if screen.width < 900
    $(".fancybox").photoSwipe
      enableMouseWheel: false
      enableKeyboard: false
      captionAndToolbarHide: false
      allowUserZoom: false
      captionAndToolbarShowEmptyCaptions: false
  else
    $(".fancybox").fancybox({
      nextMethod: 'resizeIn'
      openEffect: 'none'
    })
