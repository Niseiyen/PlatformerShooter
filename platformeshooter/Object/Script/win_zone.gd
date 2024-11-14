extends Area2D

func _on_body_entered(body: Node2D) -> void:
	load_next_level()

func load_next_level() -> void:
	var current_level = get_tree().current_scene.name
	
	var level_number = current_level.substr(5, current_level.length()) 

	var next_level_number = int(level_number) + 1
	var next_level_name = "Level" + str(next_level_number)
	
	if ResourceLoader.exists(next_level_name + ".tscn"): 
		get_tree().change_scene(next_level_name)  
	else:
		print("Le niveau suivant n'existe pas : " + next_level_name)
