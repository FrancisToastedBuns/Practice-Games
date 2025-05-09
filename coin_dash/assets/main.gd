extends Node
@export var coinScene: PackedScene
var screenSize = DisplayServer.screen_get_size()
func _ready():
	$hud/Message.text = "Coin Dash"
	$hud/MarginContainer.hide()
	$hud/Button.show()
	$Player.hide()
	

func new_game():
	$hud/Message.text = "Coin Dash"
	$hud/MarginContainer.show()
	$hud/Button.hide()
	$Player.show()
	for i in range(8):
		var scene = coinScene.instantiate()
		var rng = RandomNumberGenerator.new()
		var rndX = rng.randi_range(0, screenSize.x)
		var rndY = rng.randi_range(0, screenSize.y)
		scene.position = Vector2(rndX, rndY)
		add_child(scene)

func game_over():
	$hud/Message.text = "Game Over"
	get_tree().create_timer(2).timeout
	new_game()
	


func _on_hud_new_game() -> void:
	$hud/Message.text = "Coin Dash"
	$hud/MarginContainer.show()
	$hud/Button.hide()
	$Player.show()
	for i in range(8):
		var scene = coinScene.instantiate()
		var rng = RandomNumberGenerator.new()
		var rndX = rng.randi_range(0, screenSize.x)
		var rndY = rng.randi_range(0, screenSize.y)
		scene.position = Vector2(rndX, rndY)
		add_child(scene) # Replace with function body.


func _on_player_pick_up(type) -> void:
	match type:
		"coins":
			$hud.add_score()
		"powerups":
			$hud.add_time()
