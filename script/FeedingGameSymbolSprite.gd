extends Sprite

onready var symbols = get_parent().symbols

var _symbol

func _ready():
	pass

func set_symbol(symbol):
	print(symbols.values())
	if symbol in symbols.values():
		_symbol = symbol
		match symbol:
			symbols.HAM:
				frame_coords = Vector2(33,16)
			symbols.CHEESE:
				frame_coords = Vector2(34,16)
			symbols.FISH:
				frame_coords = Vector2(33,17)
			symbols.EGG:
				frame_coords = Vector2(34,17)
			symbols.APPLE:
				frame_coords = Vector2(33,18)
			symbols.PEAR:
				frame_coords = Vector2(34,18)
	else:
		printerr("%s Not a valid card symbol." % symbol) 
		return
	return
