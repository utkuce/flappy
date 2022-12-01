extends Node2D

var screenSize : Vector2
var score = 0

func _ready():
	screenSize = get_viewport().size * $Camera2D.zoom
	$Player.position = Vector2(screenSize.x/5, screenSize.y/2)
	$Pipes.init(screenSize)
	
func increment_score():
	score += 1
	get_node("CanvasLayer/ScoreDisplay").text = "Score: " + String(score)
