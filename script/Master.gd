extends Node

const Intro = preload("res://scene/Intro.tscn")
const Menu = preload("res://scene/Menu.tscn")
const PettingGame = preload("res://scene/PettingGame.tscn")
const FeedingGame = preload("res://scene/FeedingGame.tscn")
const KillingGame = preload("res://scene/TrapdoorGame.tscn")
const Loss = preload("res://scene/LossScreen.tscn")

class Need:
	var size : int
	var name : String
	var last = LastReduction
	var bar : Node

enum LastReduction {SMALL, MEDIUM, LARGE}

export var starting_need = 20
export var difficulty = 1

onready var current_scene = get_node("Title")
onready var hunger = Need.new()
onready var love = Need.new()
onready var bloodlust = Need.new()

var rng = RandomNumberGenerator.new()
var needs = []
var pet_name : String


# Called when the node enters the scene tree for the first time.
func _ready():
	initialize_needs()
	pass

func remove_current_scene():
	remove_child(current_scene)
	current_scene.call_deferred("free")
	return

func load_intro():
	remove_current_scene()
	var intro_scene = Intro.instance()
	add_child(intro_scene)
	current_scene = intro_scene
	return

func load_menu():
	remove_current_scene()
	var menu_scene = Menu.instance()
	set_menu_bars(menu_scene)
	add_child(menu_scene)
	current_scene = menu_scene
	return

func load_petting_game():
	remove_current_scene()
	var petting_game_scene = PettingGame.instance()
	add_child(petting_game_scene)
	current_scene = petting_game_scene
	return
	
func load_feeding_game():
	remove_current_scene()
	var feeding_game_scene = FeedingGame.instance()
	add_child(feeding_game_scene)
	current_scene = feeding_game_scene
	pass
	
func load_killing_game():
	#remove_current_scene()
	#var killing_game_scene = KillingGame.instance()
	#add_child(killing_game_scene)
	#current_scene = killing_game_scene
	pass
	
func load_lose_screen(need_name):
	remove_current_scene()
	var loss_scene = Loss.instance()
	var loss_message = loss_scene.get_node("LossMessage")
	match(need_name):
		"Hunger":
			loss_message.text = pet_name+" has starved..."
		"Love":
			loss_message.text = pet_name+" has abandoned you..."
		"Bloodlust":
			loss_message.text = pet_name+" has left to go on a rampage..."
	add_child(loss_scene)
	current_scene = loss_scene
	return

func initialize_needs():
	rng.randomize()
	hunger.name = "Hunger"
	hunger.last = LastReduction.SMALL
	hunger.size = starting_need
	love.name = "Love"
	love.last = LastReduction.MEDIUM
	love.size = starting_need
	bloodlust.name = "Bloodlust"
	bloodlust.last = LastReduction.LARGE
	bloodlust.size = starting_need
	needs.append(hunger)
	needs.append(love)
	needs.append(bloodlust)
	return
	
func set_menu_bars(menu):
	hunger.bar = menu.get_node("GUI/GridContainer/HungerBar")
	love.bar = menu.get_node("GUI/GridContainer/LoveBar")
	bloodlust.bar = menu.get_node("GUI/GridContainer/BloodlustBar")
	return

func won_game(need):
	var victory_amount = 10
	if need == "Hunger":
		hunger.size += victory_amount
		if hunger.size > starting_need:
			hunger.size = starting_need
	elif need == "Love":
		love.size += victory_amount
		if love.size > starting_need:
			love.size = starting_need
	elif need == "Bloodlust":
		bloodlust.size += victory_amount
		if bloodlust.size > starting_need:
			bloodlust.size = starting_need
	return_to_menu()
	return
	
func return_to_menu():
	load_menu()
	reduce_needs()
	return

#Reduce the need bars
func reduce_needs():
	var total = rng.randi_range(14, 18)
	var remainder = total
	var largest = total / 2
	var medium = total / 3
	remainder -= largest + medium
	var small = remainder
	
	for i in needs:
		if(i.last == LastReduction.SMALL):
			i.last = LastReduction.LARGE
			i.size -= largest
		elif(i.last == LastReduction.MEDIUM):
			i.last = LastReduction.SMALL
			i.size -= small
		else:
			i.last = LastReduction.MEDIUM
			i.size -= medium
		
		if(i.size > 0):
			i.bar.change_segment_number(i.size)
		else:
			load_lose_screen(i.name)
			break
	return
	
func restart_game():
	needs.clear()
	initialize_needs()
	load_intro()
	return
