# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready( () ->
	
	$("#custom-roll").click( custom_roll )
	$(".skill-table tr").hover( highlight_prereqs, clear_highlights )
)

add_info = (row_class) ->
	if row_class == ""
		return
	$("." + row_class).addClass("info")

clear_highlights = () ->
	$(".skill-table tr").removeClass("info warning")

custom_roll = () ->
	dice = parseInt($("#custom-roll-dice").val())
	size = parseInt($("#custom-roll-size").val())
	keep = parseInt($("#custom-roll-keep").val())
	if (isNaN(dice) || isNaN(size) || isNaN(keep))
		alert("Excuse me, that's not a number.")
	else
		roll(dice, size, keep)

highlight_prereqs = () ->
	this_row = $( this )
	this_class = this.className
	if (this.className == "")
		return
		
	this_prereqs = this_row.data("prereqs")
	if (this_prereqs != "" and this_prereqs != undefined)
		prereq_rows = this_prereqs.split(" ")
		add_info row for row in prereq_rows
	$( "." + this.className ).addClass("warning")