extends Node

signal petting_won(need)
signal petting_lost
signal petting_tutorial_accepted
signal ui_button_pressed
signal out_of_time

var _clicks = 0
var _winning_clicks = 10
var progress : float
var tutorial_seen : bool

func _ready():
	self.connect("petting_won", get_parent(), "won_game")
	self.connect("petting_lost", get_parent(), "return_to_menu")
	self.connect("petting_tutorial_accepted", get_parent(), "petting_tutorial_seen")
	self.connect("ui_button_pressed", get_parent(), "play_ui_sound")
	self.connect("out_of_time", get_parent(), "play_explode_sound")
	# set a sane default in case I left it on in the editor
	$Pet/Hearts.emitting = false
	
	$Pet.type = get_parent().pet_type
	$Pet.evolution = get_parent().current_evolution_level
	
	$Bar.change_segment_number(0)
	
	if get_parent() != null:
		tutorial_seen = get_parent().seen_petting_tutorial
	
	if tutorial_seen:
		$TutorialPopup.visible = false
		start_gameplay()
		
	get_node("Pet/AnimationPlayer").play("Walk")
	return

func start_gameplay():
	emit_signal("ui_button_pressed")
	$Timer.start()
	$ExplodeTimer.start()
	$Pet.game_started = true
	return

func tutorial_accepted():
	emit_signal("petting_tutorial_accepted")
	$TutorialPopup.visible = false
	start_gameplay()
	return

func _process(delta):
	if _clicks >= _winning_clicks:
		print("winner")
		emit_signal("petting_won", "Love")
	return

func _on_Pet_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.pressed:
			_clicks += 1
			$AnimationPlayer.play("Heart Beat")
			$Bar.change_segment_number(float(_clicks) / _winning_clicks)
			$Pet/Hearts.restart()
	return

func _on_Pet_ready():
	$Pet.tune_difficulty(get_parent().difficulty)
	return

func _on_Timer_timeout():
	print("loser")
	emit_signal("petting_lost")
	return


func _on_ExplodeTimer_timeout():
	emit_signal("out_of_time")
	return
