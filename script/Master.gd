extends Node

const Intro = preload("res://scene/Intro.tscn")
const Menu = preload("res://scene/Menu.tscn")

onready var current_scene = get_node("Title")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

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
	add_child(menu_scene)
	current_scene = menu_scene
	return
