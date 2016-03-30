ready = ->
  jQuery ->
  $("form").on "click", ".remove_fields", (event) ->
    $(this).prev("input[type=hidden]").val("1")
    $(this).closest("fieldset").hide()
    event.preventDefault()

  $("form").on "click", ".add_fields", (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data("id"), "g")
    $(this).before($(this).data("fields").replace(regexp, time))
    event.preventDefault()

  $("form").on "click", ".single_checkbox", (event) ->
    option_type_value = $(".option_type").val();
    switch option_type_value
      when "single_choice" then $(".single_checkbox").not(this).prop("checked", false)

  $("form").on "change", ".option_type", (event) ->
    option_type_value = $(this).val()
    time = new Date().getTime()
    regexp = new RegExp($('.option_type :selected').data("id"), "g")
    $(".question_option_field").html($('.option_type :selected').data("fields"))

  $("form").ready ->
    $(".question_option_field").find("input[name*=_destroy]:input[value=true]").closest("fieldset").hide()

$(document).on "ready page:load", ready
