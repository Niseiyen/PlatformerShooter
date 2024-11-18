extends Sprite2D

var can_fire = true
var fire_rate = 0.5 

@onready var laser: AudioStreamPlayer2D = $Laser
const LASER_1 = preload("res://Audio/SoundEffect/Laser1.mp3")
const LASER_2 = preload("res://Audio/SoundEffect/Laser2.mp3")
const BULLET = preload("res://Acteur/Player/Bullet.tscn")
const OFFSET_X = 10 
const OFFSET_Y = 1  

var using_mouse = true

func _ready() -> void:
	set_as_top_level(true)
	
func _physics_process(delta: float) -> void:
	position.x = lerp(position.x, get_parent().position.x + OFFSET_X, 0.5)
	position.y = lerp(position.y, get_parent().position.y + OFFSET_Y, 0.5)
	
	var axis_x = Input.get_action_strength("aim_right") - Input.get_action_strength("aim_left")
	var axis_y = Input.get_action_strength("aim_down") - Input.get_action_strength("aim_up")
	
	if abs(axis_x) > 0.1 or abs(axis_y) > 0.1:
		using_mouse = false
		rotation = atan2(axis_y, axis_x)
	else:
		using_mouse = true
	
	if using_mouse:
		var mouse_pos = get_global_mouse_position()
		look_at(mouse_pos)

	if Input.is_action_pressed("shoot") and can_fire:
		shoot()

func shoot() -> void:
	var bullet_instance = BULLET.instantiate()
	bullet_instance.rotation = rotation
	bullet_instance.global_position = $Marker2D.global_position
	get_parent().add_child(bullet_instance)
	
	laser.stream = LASER_1 if randf() < 0.5 else LASER_2
	laser.play()
	
	can_fire = false
	await get_tree().create_timer(fire_rate).timeout
	can_fire = true
