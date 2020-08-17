extends Node2D

signal feeding_won(need)
signal feeding_lost

func _ready():
	self.connect("feeding_won", get_parent(), "won_game")
	self.connect("feeding_lost", get_parent(), "return_to_menu")
	return

func game_won():
	print("winner")
	emit_signal("feeding_won", "Hunger")
	return

func _on_Timer_timeout():
	print("loser")
	emit_signal("feeding_lost")
	return

func _on_Button_pressed():
	game_won()
	return
