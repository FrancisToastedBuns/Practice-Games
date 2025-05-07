extends Area2D
@export var speed = 600
var screensize = Vector2.ZERO

func _process(delta):
	var input_direction = Input.get_vector("left", "right", "up", "down")
	if Input.is_action_pressed("right"):
		$AnimatedSprite2D.play("run")
		$AnimatedSprite2D.flip_h = false
	elif input_direction.x != 0:
		$AnimatedSprite2D.play("run")
		$AnimatedSprite2D.flip_h = true
	elif Input.is_action_pressed("up") or Input.is_action_pressed("down"):
		$AnimatedSprite2D.play("run")
	else:
		$AnimatedSprite2D.play("idle")
	position += input_direction * speed * delta
	


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("coins"):
		emit_signal("pick_up")
	elif area.is_in_group("obstacles"):
		set_process(false)
		$AnimatedSprite2D.play("die")
	elif area.is_in_group("powerups"):
		pass
		
