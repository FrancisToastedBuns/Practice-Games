extends Node

func _process(_delta: float) -> void:
	if not $Music.playing:
		$Music.play()
