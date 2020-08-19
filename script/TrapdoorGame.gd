extends Node

const Enemy = preload("res://scene/TrapdoorGame/Enemy.tscn")
const Victim = preload("res://scene/TrapdoorGame/Victim.tscn")

signal trapdoor_lost
signal trapdoor_won

var rng = RandomNumberGenerator.new()
var hp = 3
var bloodlust = 10.0

func _ready():
	rng.randomize()
	self.connect("trapdoor_lost", get_parent(), "return_to_menu")
	self.connect("trapdoor_won", get_parent(), "won_game")
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
	if type > 2:
		npc = Victim.instance()
	else:
		npc = Enemy.instance()
		
	npc.position = position
	npc.scale.x = 4
	npc.scale.y = 4
	if(direction == "Left"):
		npc.travelling_left = true
		npc.get_node("Sprite").flip_h = true
	elif(direction == "Right"):
		npc.travelling_left = false
	else:
		printerr("Bad NPCFactory direction")
		
	add_child(npc)
	return


func _on_DetectZone_body_entered(body):
	if body.is_in_group("npc"):
		get_node("Pet").add_to_hunted_list(body)
	return


func _on_Timer_timeout():
	emit_signal("trapdoor_lost")
	return
