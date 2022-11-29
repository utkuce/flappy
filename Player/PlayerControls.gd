extends RigidBody2D

export var pulse = 1200
export var gravity = 50

onready var debugInfo : CanvasLayer = $"/root/DebugInfo"
onready var velocity : float = 0

var falling: bool = false

func _ready():
	contact_monitor = true
	contacts_reported = 1
	connect("body_entered", self, "on_body_entered")
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
		player_died()

func _process(_delta):
	if OS.is_debug_build():
		debugInfo.add_line("player_velocity", "Y Velocity: " + String(velocity))
		debugInfo.add_line("player_position", "Y Position: " + String(int(position.y)))
		debugInfo.add_line("player_falling", "Falling: " + String(falling))

func on_body_entered(body: Node2D):
	if (body.name == "Pipes"):
		#disconnect("body_entered", self, "body_entered")
		player_died()

func player_died():
	print("died")
