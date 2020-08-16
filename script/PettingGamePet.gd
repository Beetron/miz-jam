extends KinematicBody2D

var x_speed
var y_speed
var velocity = Vector2()

func _ready():
	return

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.normal)
		rotate_crab()
	return

func rotate_crab():
	$CrabSprite.rotation = velocity.angle()
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
	rotate_crab() # make sure crab is sideways relative to new vector
	return
