extends Node2D

export var pulse = 1200
export var gravity = 50

onready var debugInfo : CanvasLayer = $"/root/DebugInfo"
onready var velocity : float = 0

var falling: bool = false

func _ready():
	$AnimatedSprite.play()

func _physics_process(delta):
	falling = velocity > 0
	if (falling):
		if Input.is_action_pressed("primary_input"):
			velocity = -pulse
		
	velocity += gravity
	position.y += velocity * delta
	
	# boundary checks
	if position.y < 0 || position.y > get_parent().screenSize.y:
		get_node("/root/Game").player_died()

func _process(_delta):
	if OS.is_debug_build():
		debugInfo.add_line("player_velocity", "Y Velocity: " + String(velocity))
		debugInfo.add_line("player_position", "Y Position: " + String(int(position.y)))
		debugInfo.add_line("player_falling", "Falling: " + String(falling))
