extends Control

signal restart_button_pressed

func _ready():
	self.connect("restart_button_pressed", get_parent(), "restart_game")
	$Pet.type = get_parent().pet_type
	$Pet.evolution = get_parent().current_evolution_level
	return

func _on_Restart_pressed():
	emit_signal("restart_button_pressed")
	return
