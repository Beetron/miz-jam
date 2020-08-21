extends Node2D

export var direction : String
export var spawn_time : float

var spawning = false

signal spawn_timeout(position)

func _ready():
	self.connect("spawn_timeout", get_parent(), "spawn_npc")
	emit_signal("spawn_timeout", position, direction)
	$SpawnTimer.wait_time = spawn_time
	$SpawnTimer.start()
	return

func _on_SpawnTimer_timeout():
	if spawning:
		emit_signal("spawn_timeout", position, direction)
	return
