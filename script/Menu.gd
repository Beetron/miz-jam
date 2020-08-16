extends Node

signal reduce_needs
signal feed_button_pressed
signal kill_button_pressed
signal pet_button_pressed

func _ready():
	self.connect("reduce_needs", get_parent(), "reduce_needs")
	self.connect("feed_button_pressed", get_parent(), "load_feeding_game")
	self.connect("kill_button_pressed", get_parent(), "load_killing_game")
	self.connect("pet_button_pressed", get_parent(), "load_petting_game")
	
func _on_Button_pressed():
	emit_signal("reduce_needs")
	return


func _on_Feed_pressed():
	emit_signal("feed_button_pressed")
	return


func _on_Kill_pressed():
	emit_signal("kill_button_pressed")
	return


func _on_Pet_pressed():
	emit_signal("pet_button_pressed")
	return
