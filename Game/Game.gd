extends Node2D

var screenSize : Vector2
var currentScore = 0
var bestScore = 0

func _ready():
	screenSize = get_viewport().size * $Camera2D.zoom
	start_game()
	$Camera2D.position.x -= screenSize.x/5
	$Player.position.y = screenSize.y/2
	
func player_died():
	start_game()
	
func start_game():
	currentScore = 0
	updateScoreDisplay()
	
	$Player.position.x = 0
	$Player.position.y = screenSize.y/2
	$Pipes/PipeTiles.reset(screenSize)
	
func increment_score():
	currentScore += 1
	bestScore = currentScore if currentScore > bestScore else currentScore
	updateScoreDisplay()
	
func updateScoreDisplay():
	get_node("CanvasLayer/ScoreDisplay").text = "Score: " + String(currentScore) + "\n"
	get_node("CanvasLayer/ScoreDisplay").text += "Best: " + String(bestScore)	
	
func _process(_delta):
	$Camera2D.position.x = $Player.position.x - screenSize.x/5
