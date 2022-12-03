extends Node2D

var screenSize : Vector2
var score = 0

func _ready():
	screenSize = get_viewport().size * $Camera2D.zoom
	reset()
	$Camera2D.position.x -= screenSize.x/5
	$Player.position.y = screenSize.y/2
	
func player_died():
	reset()
	
func reset():
	score = 0
	get_node("CanvasLayer/ScoreDisplay").text = "Score: " + String(score)
	$Player.position.x = 0
	$Player.position.y = screenSize.y/2
	$Pipes/PipeTiles.reset(screenSize)
	
func increment_score():
	score += 1
	get_node("CanvasLayer/ScoreDisplay").text = "Score: " + String(score)
	
func _process(_delta):
	$Camera2D.position.x = $Player.position.x - screenSize.x/5
