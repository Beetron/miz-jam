extends Node

signal pet_selected

var pet_type = "Bear"

func _ready():
	self.connect("pet_selected", get_parent(), "start_caring_for_pet")
	$Bear.type = "Bear"
	$Crab.type = "Crab"
	$Croc.type = "Croc"
	$Dog.type = "Dog"
	$Lobster.type = "Lobster"
	$Octopus.type = "Octopus"
	return
 
func _on_StartMenu_pressed():
	var pet_name = get_node("IntroGUI/HSplitContainer/LineEdit").text
	if pet_name == "":
		pet_name = "Pet"
	emit_signal("pet_selected", pet_name, pet_type)
	return


#Surely theres a better way to do this but I can't be bothered investigating

func _on_Bear_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			$Selection.position = $Bear.position
			pet_type = "Bear"
	return


func _on_Crab_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			$Selection.position = $Crab.position
			pet_type = "Crab"
	return


func _on_Dog_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			$Selection.position = $Dog.position
			pet_type = "Dog"
	return


func _on_Octopus_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			$Selection.position = $Octopus.position
			pet_type = "Octopus"
	return


func _on_Croc_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			$Selection.position = $Croc.position
			pet_type = "Croc"
	return


func _on_Lobster_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			$Selection.position = $Lobster.position
			pet_type = "Lobster"
	return
