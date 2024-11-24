extends Area2D

@export var speed = 200
@onready var raycast = $RayCast2D  

func _ready() -> void:
	set_as_top_level(true)
	raycast.enabled = true

func _process(delta: float) -> void:
	position += (Vector2.RIGHT * speed).rotated(rotation) * delta
	
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider.name == "Platform":
			queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.name == "BulletHitZone":
		print(area.name)
		area.get_parent().take_damage(1)
		queue_free() 
	else:
		queue_free()
