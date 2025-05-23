extends Area2D
@export var speed = 600
var screensize = Vector2(1920, 1080)
signal pick_up
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
	position.x = clamp(position.x, 0,  screensize.x)
	position.y = clamp(position.y, 0,  screensize.y)
	


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("coins"):
		area.pick_up()
		pick_up.emit("coins")
	elif area.is_in_group("obstacles"):
		set_process(false)
		$AnimatedSprite2D.play("die")
		pick_up.emit("obstacles")
		await get_tree().create_timer(2).timeout
		position = Vector2(783, 545)
		set_process(true)
		$AnimatedSprite2D.play("idle")
	elif area.is_in_group("powerups"):
		area.pick_up()
		pick_up.emit("powerups")
		
