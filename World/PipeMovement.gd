extends Node2D

export var gameSpeed : float = 400
var screenSize: Vector2
var offset: int

func init(screenSize):
	self.screenSize = screenSize
	
	$PipeTiles1.position.x = 0
	offset = $PipeTiles1.generate(screenSize, 0, true)
		
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
