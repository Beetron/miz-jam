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
				frame = 0
			symbols.CHEESE:
				frame = 1
			symbols.FISH:
				frame = 2
			symbols.EGG:
				frame = 3
			symbols.APPLE:
				frame = 4
			symbols.PEAR:
				frame = 5
	else:
		printerr("%s Not a valid card symbol." % symbol) 
		return
	return
