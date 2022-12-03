extends TileMap

var pipeCollider : PackedScene = preload("res://Environment/Pipes/PipeCollider.tscn") # Area2D
var scoreArea : PackedScene = preload("res://Environment/Score Area/ScoreArea.tscn") # Area2D

export var initialOffset : int = 14
export var initialPipeCount : int = 20

var gapSize : int = 4 # vertical opening size
var pipeInterval : int = 5 # horizontal distance between each pipe
var currentPipeX : int

var tileGridHeight : int
var rng = RandomNumberGenerator.new()

var pipe_top    = tile_set.find_tile_by_name("pipe_top")
var pipe_middle = tile_set.find_tile_by_name("pipe_middle")
var pipe_bottom = tile_set.find_tile_by_name("pipe_bottom")

func init(screenSize):
	tileGridHeight = (screenSize.y/cell_size.y)/scale.y
	currentPipeX = initialOffset
	
	for i in range(initialPipeCount):
		add_pipe_pair()

func reset(screenSize):
	
	yield(get_tree(), "idle_frame")
	
	# remove PipeCollider children
	for collider in get_children():
		remove_child(collider)
		collider.queue_free()
		
	# clear tiles
	clear()
	
	# reinit
	init(screenSize)

func add_pipe_pair():
	rng.randomize()
	var currentPipeY = 0
	
	# opening between two pipes from gapPosition to gapPosition + gapsize
	var gapPosition = int(rng.randf_range(1, tileGridHeight - gapSize - 2))
	
	# top pipe sprites
	while currentPipeY < gapPosition:
		set_cell(currentPipeX, currentPipeY, pipe_middle)
		currentPipeY += 1
	set_cell(currentPipeX, gapPosition, pipe_top)
	
	# top pipe collision
	var topLeft = map_to_world(Vector2(currentPipeX, 0))
	var bottomRight = map_to_world(Vector2(currentPipeX + 1, currentPipeY + 1))
	add_pipe_collider(topLeft, bottomRight)
	
	# bottom pipe sprites
	currentPipeY = gapPosition + gapSize + 1
	set_cell(currentPipeX, currentPipeY, pipe_bottom)
	currentPipeY += 1
	while currentPipeY <= tileGridHeight:
		set_cell(currentPipeX, currentPipeY, pipe_middle)
		currentPipeY += 1

	# bottom pipe collision
	topLeft = map_to_world(Vector2(currentPipeX, gapPosition + gapSize + 1))
	bottomRight = map_to_world(Vector2(currentPipeX + 1, tileGridHeight + 1))
	add_pipe_collider(topLeft, bottomRight)
	
	topLeft = map_to_world(Vector2(currentPipeX + 1, 0))
	bottomRight = map_to_world(Vector2(currentPipeX + pipeInterval, tileGridHeight + 1))
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
