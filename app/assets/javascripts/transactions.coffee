# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $('input[class="daterange"]').daterangepicker {
    locale: format: 'DD-MM-YYYY'
    startDate: '01-01-2016'
    endDate: '01-02-2016'
    singleDatePicker: true
  }
  return