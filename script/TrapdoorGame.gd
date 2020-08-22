extends Node

const Enemy = preload("res://scene/TrapdoorGame/Enemy.tscn")
const Victim = preload("res://scene/TrapdoorGame/Victim.tscn")

signal trapdoor_lost
signal trapdoor_won
signal trapdoor_tutorial_accepted

var rng = RandomNumberGenerator.new()
var hp = 3
var bloodlust = 10.0
var npc_speed_mod : float
var tutorial_mode : bool 

func _ready():
	rng.randomize()
	self.connect("trapdoor_lost", get_parent(), "return_to_menu")
	self.connect("trapdoor_won", get_parent(), "won_game")
	self.connect("trapdoor_tutorial_accepted", get_parent(), "trapdoor_tutorial_seen")
	if get_parent() != null:
		tune_difficulty(get_parent().difficulty)
		tutorial_mode = !get_parent().seen_trapdoor_tutorial
		
	if !tutorial_mode:
		start_gameplay()
		$TutorialPopup.visible = false
		get_node("TrapdoorLeft/DownArrow").visible = false
		get_node("TrapdoorMiddle/DownArrow").visible = false
		get_node("TrapdoorRight/DownArrow").visible = false
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
	get_node("GUI/BloodLustBar").change_segment_number(bloodlust / 10.0)
	if bloodlust >= 100.0:
		emit_signal("trapdoor_won", "Bloodlust")
	return

func spawn_npc(position, direction):
	var type = rng.randi_range(1,6)
	var npc : Node
	if type >= 2:
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
	emit_signal("trapdoor_tutorial_accepted")
	return
	
func start_gameplay():
	get_node("GUI/Timer").start()
	$NPCFactoryLeft.spawning = true
	$NPCFactoryRight.spawning = true
	return
