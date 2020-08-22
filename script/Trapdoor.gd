extends Node2D

export var closed = true
var first_time_opened = false

func _ready():
	$TutorialArrowAnimation.play("DownArrowBounce")
	return


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed and !$AnimationPlayer.is_playing():
			if closed:
				open()
			else:
				close()
	return
	
func open():
	$AnimationPlayer.play("Open")
	closed = false
	if first_time_opened == false:
		first_time_opened = true
		$DownArrow.visible = false
	return
	
func close():
	$AnimationPlayer.play("Close")
	closed = true
	return
