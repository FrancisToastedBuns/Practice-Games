extends Node
@export var coinScene: PackedScene
@export var powerupScene: PackedScene
var screenSize = DisplayServer.screen_get_size()
var playing = false
func _ready():
	main_menu()

func _process(_delta):
	if get_tree().get_nodes_in_group("coins").size() == 0 and playing:
		for i in range(8):
			var scene = coinScene.instantiate()
			var rng = RandomNumberGenerator.new()
			var rndX = rng.randi_range(0, 1920)
			var rndY = rng.randi_range(0, 1080)
			scene.position = Vector2(rndX, rndY)
			add_child(scene)
			$powerupTimer.start(randi_range(4, 10))
		

func main_menu():
	$hud/Message.text = "Coin Dash"
	$hud/MarginContainer.hide()
	$hud/Button.show()
	$Player.	position = Vector2(783, 545)
	$Player.hide()
	

func new_game():
	playing = true
	$hud/Message.text = "Coin Dash"
	$hud/MarginContainer.show()
	$hud/Button.hide()
	$Player.show()
	$hud/Timer.start(30)
	for i in range(8):
		var scene = coinScene.instantiate()
		var rng = RandomNumberGenerator.new()
		var rndX = rng.randi_range(0, 1920)
		var rndY = rng.randi_range(0, 1080)
		scene.position = Vector2(rndX, rndY)
		add_child(scene)
	
func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func game_over():
	playing = false
	get_tree().call_group("coins", "queue_free")
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
			$CoinSounds.play()
		"powerups":
			$hud.add_time()
			$CoinSounds.play()
		"obstacles":
			game_over()
			$HitSound.play()


func _on_hud_game_over() -> void:
	$EndSound.play()
	game_over()


func _on_powerup_timer_timeout() -> void:
	var scene = powerupScene.instantiate()
	var rng = RandomNumberGenerator.new()
	var rndX = rng.randi_range(0, 1920)
	var rndY = rng.randi_range(0, 1080)
	scene.position = Vector2(rndX, rndY)
	add_child(scene)
