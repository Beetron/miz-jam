extends TileMap

var timer
var total_cells
var remaining_string

func _ready():
	total_cells = get_used_cells().size()
	remaining_string = total_cells - 1
	print(total_cells)
	return

func _process(delta):
	if timer == null:
		timer = get_parent().get_node("Timer")
	
	if !timer.is_stopped():
		if remaining_string == 0:
			hide_cells()
			get_parent().get_node("Bomb").play()
		
		var target_string = int((timer.time_left / timer.wait_time) * total_cells)
		if remaining_string > target_string:
			burn_string()
			remaining_string -= 1
	return

func burn_string():
	var rightmost
	# cell is actually a Vector2
	for cell in get_used_cells():
		if rightmost == null:
			rightmost = cell
			continue
		elif cell.x > rightmost.x:
			rightmost = cell
	var fire = get_cell(rightmost.x, rightmost.y)
	# Move fire tile over 1 position
	set_cell(rightmost.x - 1, rightmost.y, fire)
	# Clear old fire tile
	set_cellv(rightmost, -1)

func hide_cells():
	for cell in get_used_cells():
		set_cellv(cell, -1)
