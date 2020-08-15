extends Control

const MiddleSegment = preload("res://scene/NeedBarMiddle.tscn")

#var segment_number : int
var segment_number = 12

func _ready():
	if(segment_number > 2):
		var container = get_node("HBoxContainer")
		var start = container.get_node("Start")
		for i in segment_number-2:
			var middle_segment = MiddleSegment.instance()
			middle_segment.expand = true
			container.add_child_below_node(start, middle_segment)
	return
