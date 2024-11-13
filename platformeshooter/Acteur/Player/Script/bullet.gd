extends Area2D

@export var speed = 500

func _ready() -> void:
	set_as_top_level(true)
	
func _process(delta: float) -> void:
	position += (Vector2.RIGHT * speed).rotated(rotation) * delta
	
func _physics_process(delta: float) -> void:
	await get_tree().create_timer(0.01).timeout
	set_physics_process(false)
	
# Quand la balle quitte l'écran, elle se détruit
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

# Quand la balle entre en collision avec un autre corps
func _on_area_entered(area: Area2D) -> void:
	if area.name == "BulletHitZone":
		print(area.name)
		area.get_parent().die()  
		queue_free() 
	else:
		queue_free()
