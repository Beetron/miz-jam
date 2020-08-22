extends "res://script/Pet.gd"

var x_speed
var y_speed
var velocity = Vector2()
var game_started = false

func _ready():
	return

func _physics_process(delta):
	if game_started:
		var collision = move_and_collide(velocity * delta)
		if collision:
			velocity = velocity.bounce(collision.normal)
			rotate_animal()
	return

func rotate_animal():
	$AnimalSprite.rotation = velocity.angle()
	return

func tune_difficulty(difficulty):
	match difficulty:
		1:
			x_speed = 10
			y_speed = 10
		2:
			x_speed = 100
			y_speed = 100
		3:
			x_speed = 300
			y_speed = 300
		_: # set a default and erorr
			printerr("invalid difficulty set")
			x_speed = 50
			y_speed = 50
	velocity = Vector2(x_speed, y_speed)
	rotate_animal() # make sure animal is sideways relative to new vector
	return
