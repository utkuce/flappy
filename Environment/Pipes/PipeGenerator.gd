extends TileMap

var gapSize : int = 4
var pipeInterval : int = 5 

var rng = RandomNumberGenerator.new()

enum PipeTiles {TOP = 0, MIDDLE = 1, BOTTOM = 2}

func init(viewportSize):
	
	clear()
	var tileGridSize = (viewportSize / Vector2(cell_size.x, cell_size.y) / scale).ceil()
	rng.randomize()
	
	#initial screen
	var currentPipeX = int(tileGridSize.x/2)
	while currentPipeX <= tileGridSize.x:
		
		var currentPipeY = 0
		
		var gapPosition = int(rng.randf_range(1, tileGridSize.y - gapSize - 1))
		print(gapPosition)
		
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
		
		currentPipeX += pipeInterval



func _process(delta):
	pass
