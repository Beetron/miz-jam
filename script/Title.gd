extends Node

signal game_started
signal ui_button_pressed

# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("game_started", get_parent(), "load_intro")
	self.connect("ui_button_pressed", get_parent(), "play_ui_sound")
	return
	
func _on_StartGame_pressed():
	#Start the game
	emit_signal("ui_button_pressed")
	emit_signal("game_started")
	return
