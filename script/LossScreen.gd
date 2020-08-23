extends Control

signal restart_button_pressed
signal ui_button_pressed

func _ready():
	self.connect("ui_button_pressed", get_parent(), "play_ui_sound")
	self.connect("restart_button_pressed", get_parent(), "restart_game")
	return

func _on_Restart_pressed():
	emit_signal("ui_button_pressed")
	emit_signal("restart_button_pressed")
	return
