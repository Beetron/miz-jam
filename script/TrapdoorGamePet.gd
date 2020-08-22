extends "res://script/Pet.gd"

const PATROL_SPEED = 100

const Blood = preload("res://scene/TrapdoorGame/BloodParticle.tscn")

signal collided_with_enemy
signal collided_with_victim(increase_percent)

var velocity = Vector2(PATROL_SPEED, 0)
var hunting = false
var hunting_speed = 10
var hunted_list = []

func _ready():
	self.connect("collided_with_enemy", get_parent(), "lose_hp")
	self.connect("collided_with_victim", get_parent(), "increase_bloodlust")
	return

func _physics_process(delta):
	if hunted_list.empty():
		#Patrolling
		var collision = move_and_collide(velocity * delta)
		if collision:
			velocity = velocity.bounce(collision.normal)
		if hunting:
			hunting = false
			$AnimalSprite.modulate = Color(1, 1, 1, 1)

	else:
		#Hunting
		velocity.x = (hunted_list[0].position.x - position.x) * hunting_speed
		move_and_collide(velocity * delta)
		if !hunting:
			hunting = true
			$AnimalSprite.modulate = Color(1, 0, 0, 1)
	return

func add_to_hunted_list(npc):
	if npc.died == false and !hunted_list.has(npc):
		hunted_list.append(npc)
	return


func _on_KillArea_body_entered(body):
	if body.is_in_group("npc"):
		body.died = true
		hunted_list.erase(body)
		body.call_deferred("queue_free")
		
		#This will keep adding particle emitters, 
		#but it doesn't matter cos the scene gets removed after 10 victims anyway
		var blood = Blood.instance()
		blood.emitting = true
		add_child(blood)
		
		if body.victim == true:
			emit_signal("collided_with_victim", 0.05)
		else:
			emit_signal("collided_with_enemy")
				
		if hunted_list.empty():
			if velocity.x > 0:
				velocity.x = PATROL_SPEED
			else:
				velocity.x = -PATROL_SPEED
	return
