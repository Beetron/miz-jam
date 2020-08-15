extends KinematicBody2D

var x_speed = 150
var y_speed = 175
var velocity = Vector2()

func _ready():
	#rotation = 180 # Crab go sideways
	velocity = Vector2(x_speed, y_speed) #.rotated(rotation)
	# rotate the crab
	pass

func _process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.normal)
		rotate(velocity.angle())
		if collision.collider.has_method("hit"):
			collision.collider.hit()
	pass
