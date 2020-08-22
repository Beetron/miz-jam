extends Node2D

signal petting_won(need)
signal petting_lost
signal petting_tutorial_accepted

var clicks = 0

func _ready():
	self.connect("petting_won", get_parent(), "won_game")
	self.connect("petting_lost", get_parent(), "return_to_menu")
	self.connect("petting_tutorial_accepted", get_parent(), "petting_tutorial_seen")
	# set a sane default in case I left it on in the editor
	$Pet/Hearts.emitting = false 
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
			$Pet/Hearts.restart()
			print("Total clicks: ", clicks)
	return

func _on_Pet_ready():
	$Pet.tune_difficulty(get_parent().difficulty)
	return

func _on_Timer_timeout():
	print("loser")
	emit_signal("petting_lost")
	return
