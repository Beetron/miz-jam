extends Node

const Enemy = preload("res://scene/TrapdoorGame/Enemy.tscn")
const Victim = preload("res://scene/TrapdoorGame/Victim.tscn")

signal trapdoor_lost
signal trapdoor_won
signal trapdoor_tutorial_accepted
signal ui_button_pressed
signal out_of_time

var rng = RandomNumberGenerator.new()
var hp = 3
var bloodlust = 0.05
var npc_speed_mod : float
var tutorial_mode : bool 

func _ready():
	rng.randomize()
	self.connect("trapdoor_lost", get_parent(), "return_to_menu")
	self.connect("out_of_time", get_parent(), "play_explode_sound")
	self.connect("trapdoor_won", get_parent(), "won_game")
	self.connect("trapdoor_tutorial_accepted", get_parent(), "trapdoor_tutorial_seen")
	self.connect("ui_button_pressed", get_parent(), "play_ui_sound")
	if get_parent() != null:
		tune_difficulty(get_parent().difficulty)
		tutorial_mode = !get_parent().seen_trapdoor_tutorial
		$Pet.type = get_parent().pet_type
		$Pet.evolution = get_parent().current_evolution_level
		
	if !tutorial_mode:
		start_gameplay()
		$TutorialPopup.visible = false
		get_node("TrapdoorLeft/DownArrow").visible = false
		get_node("TrapdoorMiddle/DownArrow").visible = false
		get_node("TrapdoorRight/DownArrow").visible = false
		
	get_node("Pet/AnimationPlayer").play("Walk")
	return

func tune_difficulty(difficulty):
	var game_timer = get_node("GUI/Timer")
	match difficulty:
		1:
			npc_speed_mod = 1.0
			game_timer.wait_time = 30.0
		2:
			npc_speed_mod = 1.2
			game_timer.wait_time = 20.0
		3:
			npc_speed_mod = 1.4
			game_timer.wait_time = 15.0
		_:
			printerr("Invalid difficulty set.")
	get_node("GUI/BombExplode").wait_time = game_timer.wait_time - 1
	return

func lose_hp():
	match hp:
		3:
			$GUI/HPSprite3.frame = 1
		2:
			$GUI/HPSprite2.frame = 1
		1:
			$GUI/HPSprite.frame = 1
	hp -= 1
	if(hp <= 0):
		emit_signal("trapdoor_lost")
	return

func increase_bloodlust(increase_percent):
	bloodlust += increase_percent
	get_node("GUI/BloodLustBar").change_segment_number(bloodlust)
	if bloodlust >= 0.5:
		print("trapdoor won")
		emit_signal("trapdoor_won", "Bloodlust")
	return

func spawn_npc(position, direction):
	var type = rng.randi_range(1,6)
	var npc : Node
	if type >= 3:
		npc = Victim.instance()
	else:
		npc = Enemy.instance()
		
	npc.position = position
	npc.scale.x = 4
	npc.scale.y = 4
	npc.velocity = npc.velocity * npc_speed_mod
	if(direction == "Left"):
		npc.travelling_left = true
		npc.get_node("Sprite").flip_h = true
	elif(direction == "Right"):
		npc.travelling_left = false
	else:
		printerr("Bad NPCFactory direction")
		
	call_deferred("add_child", npc)
	return


func _on_DetectZone_body_entered(body):
	if body.is_in_group("npc"):
		get_node("Pet").add_to_hunted_list(body)
	return


func _on_Timer_timeout():
	emit_signal("trapdoor_lost")
	return

func tutorial_accepted():
	tutorial_mode = false
	$TutorialPopup.visible = false
	start_gameplay()
	emit_signal("ui_button_pressed")
	emit_signal("trapdoor_tutorial_accepted")
	return
	
func start_gameplay():
	get_node("GUI/Timer").start()
	get_node("GUI/BombExplode").start()
	$NPCFactoryLeft.spawning = true
	$NPCFactoryRight.spawning = true
	return


func _on_BombExplode_timeout():
	emit_signal("out_of_time")
	return
