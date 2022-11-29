extends TileMap

var gapSize : int = 5 # vertical opening size
var pipeInterval : int = 5 # horizontal distance between each pipe

var currentPipeX: int

var tileGridSize: Vector2
var rng = RandomNumberGenerator.new()

enum PipeTiles {TOP = 0, MIDDLE = 1, BOTTOM = 2}

func generate(screenSize: Vector2, offset: int = 0) -> int:
	clear()
	tileGridSize = (screenSize / Vector2(cell_size.x, cell_size.y) / scale).ceil()
	
	#initially fill the second half of the screen
	currentPipeX = offset
	while currentPipeX < tileGridSize.x:	
		add_pipe()
		
	return currentPipeX - int(tileGridSize.x)

func add_pipe():
	rng.randomize()
	var currentPipeY = 0
	var gapPosition = int(rng.randf_range(1, tileGridSize.y - gapSize - 1))
	
	# top pipe
	while currentPipeY < gapPosition:
		set_cell(currentPipeX, currentPipeY, PipeTiles.MIDDLE)
		currentPipeY += 1
	set_cell(currentPipeX, gapPosition + gapSize, PipeTiles.TOP)
	
	# bottom pipe
	set_cell(currentPipeX, gapPosition, PipeTiles.BOTTOM)
	currentPipeY = gapPosition + gapSize + 1		
	while currentPipeY <= tileGridSize.y:
		set_cell(currentPipeX, currentPipeY, PipeTiles.MIDDLE)
		currentPipeY += 1
	
	# next pipe x position
	currentPipeX += pipeInterval
