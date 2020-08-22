extends Control

const StartSegment = preload("res://scene/NeedBarStart.tscn")
const MiddleSegment = preload("res://scene/NeedBarMiddle.tscn")
const EndSegment = preload("res://scene/NeedBarEnd.tscn")

const MAX_SEGMENT_NUMBER = 20

#Max should be 20
var segment_number : int
export var starting_segment_number = 1.0

func _ready():
	change_segment_number(starting_segment_number)
	return

func change_segment_number(percent):
	segment_number = int(percent * MAX_SEGMENT_NUMBER)
	var container = get_node("HBoxContainer")
	
	for i in container.get_children():
		container.remove_child(i)
		i.queue_free()
	
	if segment_number >= 1:
		var start_segment = StartSegment.instance()
		container.add_child(start_segment)
		if segment_number >= 2:
			if segment_number >= 3:
				for i in segment_number-2:
					var middle_segment = MiddleSegment.instance()
					container.add_child(middle_segment)
			var end_segment = EndSegment.instance()
			container.add_child(end_segment)
	container.margin_right = segment_number * 32
	return
