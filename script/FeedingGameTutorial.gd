extends Control

signal tutorial_ok

func _ready():
	self.connect("tutorial_ok", get_parent(), "tutorial_accepted")
	return
	
func _on_OK_pressed():
	emit_signal("tutorial_ok")
	return
