extends TileMap

var gapSize : int = 4 # vertical opening size
var pipeInterval : int = 5 # horizontal distance between each pipe
var pipeCollider : PackedScene = preload("res://Environment/Pipes/PipeCollider.tscn") # Area2D
var scoreArea : PackedScene = preload("res://Environment/ScoreArea.tscn") # Area2D
var currentPipeX: int

var tileGridSize: Vector2
var rng = RandomNumberGenerator.new()

enum PipeTiles {TOP = 0, MIDDLE = 1, BOTTOM = 2}

func generate(screenSize: Vector2, offset: int = 0) -> int:
	# remove PipeCollider children
	for child in get_children():
		remove_child(child)
		
	# clear tiles
	clear()
		
	# visible size in tile units
	tileGridSize = (screenSize / Vector2(cell_size.x, cell_size.y) / scale).ceil()
	cell_quadrant_size = tileGridSize.x * tileGridSize.y
	
	#initially fill the second half of the screen
	currentPipeX = offset
	while currentPipeX < tileGridSize.x:	
		add_pipe_pair()
		
	# return remaining empty tiles so the next tilemap can adjust
	# its starting point for a constant interval 
	return currentPipeX - int(tileGridSize.x)

func add_pipe_pair():
	rng.randomize()
	var currentPipeY = 0
	
	# opening between two pipes from gapPosition to gapPosition + gapsize
	var gapPosition = int(rng.randf_range(1, tileGridSize.y - gapSize - 2))
	
	# top pipe sprites
	while currentPipeY < gapPosition:
		set_cell(currentPipeX, currentPipeY, PipeTiles.MIDDLE)
		currentPipeY += 1
	set_cell(currentPipeX, gapPosition, PipeTiles.BOTTOM)
	
	# top pipe collision
	var topLeft = map_to_world(Vector2(currentPipeX, 0))
	var bottomRight = map_to_world(Vector2(currentPipeX + 1, currentPipeY + 1))
	add_pipe_collider(topLeft, bottomRight)
	
	# bottom pipe sprites
	currentPipeY = gapPosition + gapSize + 1	
	set_cell(currentPipeX, currentPipeY, PipeTiles.TOP)
	currentPipeY += 1		
	while currentPipeY <= tileGridSize.y:
		set_cell(currentPipeX, currentPipeY, PipeTiles.MIDDLE)
		currentPipeY += 1

	# bottom pipe collision
	topLeft = map_to_world(Vector2(currentPipeX, gapPosition + gapSize + 1))
	bottomRight = map_to_world(Vector2(currentPipeX + 1, tileGridSize.y + 1))
	add_pipe_collider(topLeft, bottomRight)
	
	topLeft = map_to_world(Vector2(currentPipeX + 1, 0))
	bottomRight = map_to_world(Vector2(currentPipeX + pipeInterval, tileGridSize.y + 1))
	add_score_area(topLeft, bottomRight)
	
	# next pipe x position in tile units
	currentPipeX += pipeInterval

func add_pipe_collider(topLeft, bottomRight):
	var pc = pipeCollider.instance()
	pc.set_corners(topLeft, bottomRight)
	add_child(pc)

func add_score_area(topLeft, bottomRight):
	var sa = scoreArea.instance()
	sa.set_corners(topLeft, bottomRight)
	add_child(sa)
