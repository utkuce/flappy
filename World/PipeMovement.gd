extends StaticBody2D

# Scrolling speed of the game
export var gameSpeed : float = 400
# First pipe position when the game starts (in tile units)
export var initialOffset: int

var offset: int
var screenSize: Vector2

func init(screenSize):
	self.screenSize = screenSize
	
	$PipeTiles1.position.x = 0
	offset = $PipeTiles1.generate(screenSize, initialOffset)
		
	$PipeTiles2.position.x = screenSize.x
	offset = $PipeTiles2.generate(screenSize, offset)

func _physics_process(delta):
	$PipeTiles1.position.x -= gameSpeed * delta
	$PipeTiles2.position.x -= gameSpeed * delta

	if $PipeTiles1.position.x < -screenSize.x:
		$PipeTiles1.position.x = screenSize.x
		offset = $PipeTiles1.generate(screenSize, offset)

	if $PipeTiles2.position.x < -screenSize.x:
		$PipeTiles2.position.x = screenSize.x
		offset = $PipeTiles2.generate(screenSize, offset)
