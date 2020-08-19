extends Node

signal feed_button_pressed
signal kill_button_pressed
signal pet_button_pressed
signal fadeout_complete
signal evolution_complete

var rng = RandomNumberGenerator.new()
var move_to_win_screen = false

onready var pet_name = get_parent().pet_name

func _ready():
	rng.randomize()
	self.connect("fadeout_complete", get_parent(), "load_lose_screen")
	self.connect("evolution_complete", get_parent(), "load_win_screen")
	
	self.connect("feed_button_pressed", get_parent(), "load_feeding_game")
	self.connect("kill_button_pressed", get_parent(), "load_trapdoor_game")
	self.connect("pet_button_pressed", get_parent(), "load_petting_game")
	var feed_button = get_node("GUI/Feed")
	var pet_button = get_node("GUI/Pet")
	var kill_button = get_node("GUI/Kill")
	feed_button.text = "Feed "+pet_name+"."
	pet_button.text = "Pet "+pet_name+"."
	kill_button.text = "Satisfy "+pet_name+"'s bloodlust."
	
	get_parent().hunger.bar = get_node("GUI/GridContainer/HungerBar")
	get_parent().love.bar = get_node("GUI/GridContainer/LoveBar")
	get_parent().bloodlust.bar = get_node("GUI/GridContainer/BloodlustBar")
	return
	
func _process(delta):
	if !$FadeoutTimer.is_stopped():
		#Fadeout our pet over the time
		var pet_sprite = get_node("Pet/CrabSprite")
		var previous_color = pet_sprite.modulate
		previous_color[3] = previous_color[3] - delta / $FadeoutTimer.wait_time
		pet_sprite.modulate = previous_color
	return	

func _on_Feed_pressed():
	emit_signal("feed_button_pressed")
	return

func _on_Kill_pressed():
	emit_signal("kill_button_pressed")
	return

func _on_Pet_pressed():
	emit_signal("pet_button_pressed")
	return

func _on_FadeoutTimer_timeout():
	emit_signal("fadeout_complete")
	return

func evolve(has_won):
	$GUI.visible = false
	#TODO: animate evolution later
	move_to_win_screen = has_won
	$ReturnTimer.start()
	return

func _on_ReturnTimer_timeout():
	if move_to_win_screen:
		emit_signal("evolution_complete")
	$GUI.visible = true
	return

#Reduce the need bars
func reduce_needs():
	var total = rng.randi_range(7, 10)
	var remainder = total
	var largest = total / 2
	var medium = total / 3
	remainder -= largest + medium
	var small = remainder
	
	for i in get_parent().needs:
		if(i.last == get_parent().LastReduction.SMALL):
			i.last = get_parent().LastReduction.LARGE
			i.size -= largest
		elif(i.last == get_parent().LastReduction.MEDIUM):
			i.last = get_parent().LastReduction.SMALL
			i.size -= small
		else:
			i.last = get_parent().LastReduction.MEDIUM
			i.size -= medium
		
		if(i.size > 0):
			i.bar.change_segment_number(i.size)
		else:
			i.bar.change_segment_number(0)
			get_parent().lost_from = i.name
			get_node("GUI/Feed").visible = false
			get_node("GUI/Pet").visible = false
			get_node("GUI/Kill").visible = false
			$FadeoutTimer.start()
			break
	return
