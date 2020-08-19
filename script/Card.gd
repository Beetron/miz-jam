extends Area2D

signal card_pressed(id)

enum symbols {HAM, CHEESE, FISH, EGG, APPLE, PEAR}

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

# Sets the symbol on the card
func set_card(symbol):
	print(symbols.values())
	if symbol in symbols.values():
		_symbol = symbol
		match symbol:
			symbols.HAM:
				$SymbolSprite.frame_coords = Vector2(33,16)
			symbols.CHEESE:
				$SymbolSprite.frame_coords = Vector2(34,16)
			symbols.FISH:
				$SymbolSprite.frame_coords = Vector2(33,17)
			symbols.EGG:
				$SymbolSprite.frame_coords = Vector2(34,17)
			symbols.APPLE:
				$SymbolSprite.frame_coords = Vector2(33,18)
			symbols.PEAR:
				$SymbolSprite.frame_coords = Vector2(34,18)
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
			emit_signal("card_pressed", self)
	return
