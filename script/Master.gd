extends Node

const Intro = preload("res://scene/Intro.tscn")


onready var current_scene = get_node("Title")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func load_intro():
	remove_child(current_scene)
	current_scene.call_deferred("free")
	var intro_scene = Intro.instance()
	add_child(intro_scene)
	current_scene = intro_scene
	return
