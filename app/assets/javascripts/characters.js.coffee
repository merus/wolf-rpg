# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready( () ->
	add_info = (row_class) ->
		if row_class == ""
			return
		$("." + row_class).addClass("info")

	$(".skill-table tr").hover( () ->
		this_row = $( this )
		this_prereqs = this_row.data("prereqs")
		if (this_prereqs != "" and this_prereqs != undefined)
			prereq_rows = this_prereqs.split(" ")
			add_info row for row in prereq_rows
		$( "." + this.className ).addClass("warning")
	, () ->
		$(".skill-table tr").removeClass("info warning")
	)
)