extends Node2D

export var pulse = 750
export var gravity = 25

onready var debugInfo : CanvasLayer = get_node("/root/DebugInfo")
onready var velocity : float = 0

func _ready():
	$AnimatedSprite.play()
	pass

func _physics_process(delta):
	var falling = velocity > 0
	if (falling):
		if Input.is_action_pressed("primary_input"):
			velocity = -pulse
		
	velocity += gravity
	position.y += velocity * delta

	debugInfo.add_line("player_velocity", "Velocity: " + String(velocity))
	debugInfo.add_line("player_position", "Y Position: " + String(int(position.y)))
	debugInfo.add_line("player_falling", "Falling: " + String(falling))
