extends RigidBody2D
@export var Bullet : PackedScene
@export var explosion_sound : Resource

enum {INIT, ALIVE, INVULNERABLE, DEAD}
var player_state

var recently_shot = true
var rotation_speed = 8000
var spinning = 0
var thrust = Vector2.ZERO
var engine_power = 300

var rotation_dir = 0
var screensize = Vector2.ZERO
var can_shoot = true
var reset_pos = false


func _ready() -> void:
	player_state = DEAD

func _physics_process(_delta):
	constant_torque = rotation_speed * spinning
	constant_force = thrust
	screensize = get_viewport_rect().size

func _process(_delta: float) -> void:
	get_input()
	
func get_input():
	if player_state == DEAD:
		return
	thrust = Vector2.ZERO
	spinning = Input.get_axis("rotate_left","rotate_right")
	if Input.is_action_pressed("thrust"):
		thrust = transform.x * engine_power
	if Input.is_action_pressed("shoot"):
		if can_shoot:
			shoot()
			can_shoot = false
			await get_tree().create_timer(0.3).timeout
			can_shoot = true
func shoot():
	var b = Bullet.instantiate()
	get_tree().root.add_child(b)
	b.start($Muzzle.global_transform)
	$BulletSound.play()
func _integrate_forces(physics_state):
	if reset_pos:
		physics_state.transform.origin = screensize / 2
		reset_pos = false
	var xform = physics_state.transform
	xform.origin.x = wrapf(xform.origin.x, 0, screensize.x)
	xform.origin.y = wrapf(xform.origin.y, 0, screensize.y)
	physics_state.transform = xform
