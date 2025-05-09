extends Node
@export var coinScene: PackedScene
var screenSize = DisplayServer.screen_get_size()
func _ready():
	main_menu()

func main_menu():
	$hud/Message.text = "Coin Dash"
	$hud/MarginContainer.hide()
	$hud/Button.show()
	$Player.	position = Vector2(783, 545)
	$Player.hide()
	

func new_game():
	$hud/Message.text = "Coin Dash"
	$hud/MarginContainer.show()
	$hud/Button.hide()
	$Player.show()
	$hud/Timer.start(30)
	for i in range(8):
		var scene = coinScene.instantiate()
		var rng = RandomNumberGenerator.new()
		var rndX = rng.randi_range(0, screenSize.x)
		var rndY = rng.randi_range(0, screenSize.y)
		scene.position = Vector2(rndX, rndY)
		add_child(scene)
	
func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func game_over():
	$hud/Message.show()
	$hud/Message.text = "Game Over"
	await wait(2)
	main_menu()

func _on_hud_new_game() -> void:
	new_game()

func _on_player_pick_up(type) -> void:
	match type:
		"coins":
			$hud.add_score()
		"powerups":
			$hud.add_time()
		"obstacles":
			game_over()


func _on_hud_game_over() -> void:
	game_over()
