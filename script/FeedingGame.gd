extends Node2D

signal feeding_won(need)
signal feeding_lost

const Card = preload("res://scene/Card.tscn")
# Pull in the enums for the types of card
onready var card_symbols = Card.instance().symbols

# Artisanal handmade magic spacing numbers
const spacing_x = 60
const spacing_y = 86

var cards = []
var num_cards
var grid_size
var used_symbols
var starting_x = 370
var starting_y = 100

func _ready():
	self.connect("feeding_won", get_parent(), "won_game")
	self.connect("feeding_lost", get_parent(), "return_to_menu")
	tune_difficulty(get_parent().difficulty)
	setup_board()
	return

func game_won():
	print("winner")
	emit_signal("feeding_won", "Hunger")
	return

func tune_difficulty(difficulty):
	match difficulty:
		1:
			num_cards = 4
			grid_size = Vector2(2,2)
		2:
			num_cards = 8
			grid_size = Vector2(4,2)
			starting_x = starting_x - spacing_x
		3:
			num_cards = 12
			grid_size = Vector2(4,3)
			starting_x = starting_x - spacing_x
		_: # set a default and erorr
			printerr("invalid difficulty set")
			num_cards = 4
	return

func setup_board():
	# Shuffle the possible symbol list
	randomize()
	used_symbols = card_symbols.values()
	used_symbols.shuffle()
	# Select the needed number of symbols (num_cards/2 as we want pairs), 
	used_symbols = used_symbols.slice(0,(num_cards/2) - 1)
	
	# Create a randomised array with two of each symbols.
	var symbol_stack = []
	for x in used_symbols:
		symbol_stack.append(x)
		symbol_stack.append(x)
	symbol_stack.shuffle()
	
	# Loop over our grid and pop the next symbol off the stack
	for x in grid_size.x:
		for y in grid_size.y:
			add_card(starting_x + (x * spacing_x), starting_y + (y * spacing_y), symbol_stack.pop_back())
	return

func add_card(x, y, type):
	var card_scene = Card.instance()
	cards.append(card_scene)
	card_scene.position = Vector2(x, y)
	add_child(card_scene)
	card_scene.connect("card_pressed", self, "_on_card_pressed_event")
	card_scene.set_card(type)

func _on_Timer_timeout():
	print("loser")
	emit_signal("feeding_lost")
	return

func _on_card_pressed_event(id):
	print("Received press for card: ", id)
	id.input_pickable = false
	
	var any_pickable = false
	for x in cards:
		if x.input_pickable == true:
			any_pickable = true
	
	if not any_pickable:
		for x in cards:
			x.flip()
			x.input_pickable = true
	return
