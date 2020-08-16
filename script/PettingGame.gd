extends Node2D

signal petting_won
signal peting_lost

var difficulty = 2
var clicks = 0

func _ready():
	self.connect("petting_won", get_parent(), "load_intro")
	self.connect("peting_lost", get_parent(), "load_intro")
	return

func _process(delta):
	if clicks >= 10:
		print("winner")
		emit_signal("petting_won")
	$Label.text = String($Timer.time_left)
	return

func _on_Pet_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.pressed:
			#print("Mouse Click at: ", event.position)
			clicks += 1
			print("Total clicks: ", clicks)
	return

func _on_Pet_ready():
	$Pet.tune_difficulty(difficulty)
	return

func _on_Timer_timeout():
	print("loser")
	emit_signal("petting_lost")
	return
