extends Node
var playing = false
func _process(_delta: float) -> void:
	if not $Music.playing and playing:
		$Music.play()
	elif not $Music.playing:
		return

func _ready() -> void:
	$Player.hide()

func _on_hud_start() -> void:
	playing = true
	$Player.show()
	$Player.player_state = ALIVE
