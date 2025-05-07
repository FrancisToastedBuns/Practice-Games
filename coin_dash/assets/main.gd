extends Node
@export var coinScene: PackedScene
var screenSize = DisplayServer.screen_get_size()
func _ready():
	for i in range(8):
		var scene = coinScene.instantiate()
		var rng = RandomNumberGenerator.new()
		var rndX = rng.randi_range(0, screenSize.x)
		var rndY = rng.randi_range(0, screenSize.y)
		scene.position = Vector2(rndX, rndY)
		add_child(scene)
#func _process(delta):
	#if not switch:
		#drums()
		#switch = true
 
