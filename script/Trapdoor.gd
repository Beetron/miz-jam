extends Node2D

export var closed = true

func _ready():
	pass


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
	return
	
func close():
	$AnimationPlayer.play("Close")
	closed = true
	return
