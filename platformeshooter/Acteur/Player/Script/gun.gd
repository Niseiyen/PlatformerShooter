extends Sprite2D

var can_fire = true
var fire_rate = 0.5 

const BULLET = preload("res://Acteur/Player/Bullet.tscn")
const OFFSET_X = 10 
const OFFSET_Y = 1  

func _ready() -> void:
	set_as_top_level(true)
	
func _physics_process(delta: float) -> void:
	position.x = lerp(position.x, get_parent().position.x + OFFSET_X, 0.5)
	position.y = lerp(position.y, get_parent().position.y + OFFSET_Y, 0.5)
	
	var mouse_pos = get_global_mouse_position()
	look_at(mouse_pos)
	
	if Input.is_action_pressed("shoot") and can_fire:
		var bullet_instance = BULLET.instantiate()
		bullet_instance.rotation = rotation
		bullet_instance.global_position = $Marker2D.global_position
		get_parent().add_child(bullet_instance)
		can_fire = false
		await get_tree().create_timer(fire_rate).timeout 
		can_fire = true
