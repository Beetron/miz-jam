extends Node

signal game_started

# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("game_started", get_parent(), "load_intro")
	return
	
func _on_StartGame_pressed():
	#Start the game
	emit_signal("game_started")
	return
