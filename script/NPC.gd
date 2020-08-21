extends KinematicBody2D

const GRAVITY = 50.0

var walk_speed : float
var velocity = Vector2()
var rng = RandomNumberGenerator.new()
var travelling_left : bool
var died = false
export var victim : bool

func _ready():
	rng.randomize()
	walk_speed = rng.randf_range(40, 160)
	travelling_left = rng.randi_range(0, 1)
	$Sprite.frame = rng.randi_range(0, 5)
	$AnimationPlayer.play("Walk")
	return

func _physics_process(delta):
	velocity.y += delta * GRAVITY
	
	if travelling_left:
		velocity.x = -walk_speed
	else:
		velocity.x = walk_speed
	
	move_and_slide(velocity, Vector2(0, -1))
	return
