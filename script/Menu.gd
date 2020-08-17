extends Node

signal reduce_needs
signal feed_button_pressed
signal kill_button_pressed
signal pet_button_pressed
signal fadeout_complete

onready var pet_name = get_parent().pet_name

func _ready():
	self.connect("reduce_needs", get_parent(), "reduce_needs")
	self.connect("fadeout_complete", get_parent(), "load_lose_screen")
	
	self.connect("feed_button_pressed", get_parent(), "load_feeding_game")
	self.connect("kill_button_pressed", get_parent(), "load_killing_game")
	self.connect("pet_button_pressed", get_parent(), "load_petting_game")
	var feed_button = get_node("GUI/Feed")
	var pet_button = get_node("GUI/Pet")
	var kill_button = get_node("GUI/Kill")
	feed_button.text = "Feed "+pet_name+"."
	pet_button.text = "Pet "+pet_name+"."
	kill_button.text = "Satisfy "+pet_name+"'s bloodlust."
	return
	
func _process(delta):
	if !$FadeoutTimer.is_stopped():
		#Fadeout our pet over the time
		var pet_sprite = get_node("Pet/CrabSprite")
		var previous_color = pet_sprite.modulate
		previous_color[3] = previous_color[3] - delta / $FadeoutTimer.wait_time
		pet_sprite.modulate = previous_color
	return	

func _on_Button_pressed():
	emit_signal("reduce_needs")
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


func trigger_lose_anim():
	$FadeoutTimer.start()
	return

func _on_FadeoutTimer_timeout():
	emit_signal("fadeout_complete")
	return
