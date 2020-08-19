extends Area2D

func _ready():
	pass


func _on_NPCKillZone_body_entered(body):
	if body.is_in_group("npc"):
		body.call_deferred("queue_free")
	return
