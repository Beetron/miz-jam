extends Control

const MiddleSegment = preload("res://scene/NeedBarMiddle.tscn")
const EndSegment = preload("res://scene/NeedBarEnd.tscn")

#Max should be 8
var segment_number = 4

func _ready():
	var container = get_node("HBoxContainer")
	var start = container.get_node("Start")
	if(segment_number > 1):
		for i in segment_number-2:
			var middle_segment = MiddleSegment.instance()
			middle_segment.expand = true
			container.add_child(middle_segment)
		var end_segment = EndSegment.instance()
		end_segment.expand = true
		container.add_child(end_segment)
		
	container.margin_right = segment_number * 64
	return
