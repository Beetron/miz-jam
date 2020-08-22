extends Area2D

signal card_pressed(card)
signal shake_finished(card)

onready var symbols = get_node("/root/Master/FeedingGame").symbols

var _facedown
var _symbol

func _ready():
	_facedown = true
	return

func flip():
	if _facedown:
		$AnimationPlayer.play("Flip to front")
		_facedown = false
	else:
		$AnimationPlayer.play("Flip to back")
		_facedown = true
	return

func shake():
	$AnimationPlayer.play("Shake")
	return

func sparkle():
	$Sparkle.emitting = true
	return

# Sets the symbol on the card
func set_card(symbol):
	if symbol in symbols.values():
		_symbol = symbol
		match symbol:
			symbols.HAM:
				$SymbolSprite.frame = 0
			symbols.CHEESE:
				$SymbolSprite.frame = 1
			symbols.FISH:
				$SymbolSprite.frame = 2
			symbols.EGG:
				$SymbolSprite.frame = 3
			symbols.APPLE:
				$SymbolSprite.frame = 4
			symbols.PEAR:
				$SymbolSprite.frame = 5
	else:
		printerr("%s Not a valid card symbol." % symbol) 
		return
	return

func get_symbol():
	return _symbol

func _on_Card_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.pressed:
			flip()
			yield($AnimationPlayer, "animation_finished")
			emit_signal("card_pressed", self)
	return
