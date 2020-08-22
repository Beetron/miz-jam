extends KinematicBody2D

export var type : String setget type_set, type_get
export var evolution = 1 setget evolution_set, evolution_get

func _ready():
	pass
	
func type_set(new_type):
	type = new_type
	match new_type:
		"Bear":
			$AnimalSprite.frame = 0
		"Crab":
			$AnimalSprite.frame = 1
		"Croc":
			$AnimalSprite.frame = 2
		"Dog":
			$AnimalSprite.frame = 3
		"Lobster":
			$AnimalSprite.frame = 4
		"Octopus":
			$AnimalSprite.frame = 5
	return
	
func type_get():
	return type
	
func evolution_set(new_evolution_level):
	if new_evolution_level < 1 or new_evolution_level > 4:
		printerr("Invalid evolution level attempted to be set")
	else:
		evolution = new_evolution_level
		match evolution:
			1:
				$Evolution2.visible = false
				$Evolution3.visible = false
				$Evolution4.visible = false
			2:
				$Evolution2.visible = true
				$Evolution3.visible = false
				$Evolution4.visible = false
			3:
				$Evolution2.visible = false
				$Evolution3.visible = true
				$Evolution4.visible = false
			4:
				$Evolution2.visible = false
				$Evolution3.visible = false
				$Evolution4.visible = true
	return
	
func evolution_get():
	return evolution
