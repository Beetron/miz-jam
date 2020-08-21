extends Node

signal pet_selected

func _ready():
	self.connect("pet_selected", get_parent(), "load_menu")
	return
 
func _on_StartMenu_pressed():
	var pet_name = get_node("IntroGUI/HSplitContainer/LineEdit").text
	if pet_name == "":
		pet_name = "Crab"
	get_parent().pet_name = pet_name
	emit_signal("pet_selected")
	return
