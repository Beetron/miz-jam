extends Node2D

signal petting_won(need)
signal petting_lost

var clicks = 0

func _ready():
	self.connect("petting_won", get_parent(), "won_game")
	self.connect("petting_lost", get_parent(), "return_to_menu")
	return

func _process(delta):
	if clicks >= 10:
		print("winner")
		emit_signal("petting_won", "Love")
	return

func _on_Pet_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.pressed:
			clicks += 1
			print("Total clicks: ", clicks)
	return

func _on_Pet_ready():
	$Pet.tune_difficulty(get_parent().difficulty)
	return

func _on_Timer_timeout():
	print("loser")
	emit_signal("petting_lost")
	return
