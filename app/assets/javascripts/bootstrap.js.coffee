jQuery ->
  $("a[rel~=popover], .has-popover").popover()
  $("a[rel~=tooltip], .has-tooltip").tooltip()

  setTimeout (->
    $(".alert-dismissable").fadeTo(500, 0).slideUp 500, ->
      $ @remove()

  ), 2000