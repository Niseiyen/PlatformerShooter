extends Area2D

@export var speed = 400

func _process(delta):
	position += Vector2(cos(rotation), sin(rotation)) * speed * delta
	
	if not get_viewport_rect().encloses(Rect2(global_position, Vector2(1, 1))):
		queue_free()
