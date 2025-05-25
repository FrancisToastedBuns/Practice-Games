extends RigidBody2D
@export var Bullet : PackedScene

func _physics_process(delta):
	if Input.is_action_just_pressed("shoot"):
		shoot()

func shoot():
	var b = Bullet.instantiate()
	add_child(b)
	b.transform = $Muzzle.transform
