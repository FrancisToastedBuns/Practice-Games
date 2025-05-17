extends Area2D

func _ready():
	$Timer.start(randi_range(3, 10))

func pick_up():
	queue_free()



func _on_timer_timeout() -> void:
	queue_free()
