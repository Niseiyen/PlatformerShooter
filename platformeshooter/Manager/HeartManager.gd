extends HBoxContainer

const heart_scene = preload("res://GUI/heart.tscn")
const full_heart_texture = preload("res://kenney_pixel-platformer/Tiles/tile_0044.png")
const empty_heart_texture = preload("res://kenney_pixel-platformer/Tiles/tile_0046.png")

var hearts: Array = []

func setup_hearts(max_health: int) -> void:
	for heart in hearts:
		heart.queue_free()
	hearts.clear()
	
	for i in range(max_health):
		var heart_instance = heart_scene.instantiate()
		add_child(heart_instance)
		hearts.append(heart_instance)
	
	update_hearts(max_health)

func update_hearts(current_health: int) -> void:
	for i in range(hearts.size()):
		var heart_texture_rect = hearts[i].get_node("HeartImage") 
		if i < current_health:
			heart_texture_rect.texture = full_heart_texture  
		else:
			heart_texture_rect.texture = empty_heart_texture 
