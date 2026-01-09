extends RigidBody2D
@export var Bullet : PackedScene
var recently_shot = true

func _physics_process(delta):
	if Input.is_action_pressed("shoot"):
		print("testing")
		if recently_shot:
			shoot()
			recently_shot = false
			await get_tree().create_timer(0.3).timeout
			recently_shot = true
	if Input.is_action_just_pressed("rotate_left"):
		$P
	if Input.is_action_just_pressed("rotate_right"):
		shoot()
	if Input.is_action_just_pressed("thrust"):
		shoot()
	if Input.is_action_just_pressed("pause"):
		shoot()

func shoot():
	var b = Bullet.instantiate()
	add_child(b)
	b.transform = $Muzzle.transform
