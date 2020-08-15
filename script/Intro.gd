extends Node

signal pet_selected

func _ready():
	self.connect("pet_selected", get_parent(), "load_menu")
	return
 
func _on_StartMenu_pressed():
	emit_signal("pet_selected")
	return
