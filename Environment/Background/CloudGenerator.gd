extends TileMap

var screenSize : Vector2
var tileGridHeight : int
var rng = RandomNumberGenerator.new()

var clouds_autotile = tile_set.find_tile_by_name("clouds autotile")

var lastCloudEnd = Vector2.ZERO
var maxDeltaX = 5
var maxCloudLength = 5

onready var player = get_node("/root/Game/Player")

func init(ss):
	screenSize = ss
	tileGridHeight = (screenSize.y/cell_size.y)/scale.y
	lastCloudEnd = Vector2.ZERO
#	for i in range(20):
#		add_cloud()

func reset(screenSize):
	yield(get_tree(), "idle_frame") # wait for new frame
	clear() # clear tiles
	init(screenSize) # reinit

func add_cloud():
	rng.randomize()
	var deltaX = int(rng.randf_range(1, maxDeltaX))
	var deltaY = int(rng.randf_range(-lastCloudEnd.y, tileGridHeight - lastCloudEnd.y))
	if deltaY == 0:
		deltaY = 1
	
	var newCloudPos = Vector2(lastCloudEnd.x + deltaX, lastCloudEnd.y + deltaY)
#	print(get_parent().name, " ", newCloudPos)
	var cloudLength = int(rng.randf_range(2, maxCloudLength))
	for i in range(cloudLength):
		set_cell(newCloudPos.x + i, newCloudPos.y, clouds_autotile, false, true)
		update_bitmask_region()
		
	lastCloudEnd = newCloudPos + Vector2(cloudLength,0)

func _process(delta):
	if (player):
#		print(screenSize.x, " ", lastCloudEnd.x - player.position.x)
		if (screenSize.x > abs(lastCloudEnd.x * cell_size.x - player.position.x)):
			add_cloud()
