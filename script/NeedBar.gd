extends Control

const MiddleSegment = preload("res://scene/NeedBarMiddle.tscn")
const EndSegment = preload("res://scene/NeedBarEnd.tscn")

#Max should be 20
var segment_number : int
export var starting_segment_number = 20

func _ready():
	change_segment_number(starting_segment_number)
	return

func change_segment_number(new_seg_number):
	segment_number = new_seg_number
	var container = get_node("HBoxContainer")
	var start = container.get_node("Start")
	for i in container.get_children():
		if i.name != "Start":
			container.remove_child(i)
			i.queue_free()
	if(segment_number > 1):
		for i in segment_number-2:
			var middle_segment = MiddleSegment.instance()
			container.add_child(middle_segment)
		var end_segment = EndSegment.instance()
		container.add_child(end_segment)
	else:
		container.remove_child(start)
		start.queue_free()
		
	container.margin_right = segment_number * 32
	return
