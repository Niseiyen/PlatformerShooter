extends Sprite2D

func _process(delta):
	var mouse_position = get_global_mouse_position()
	
	var direction = (mouse_position - global_position).normalized()
	
	rotation = direction.angle()
