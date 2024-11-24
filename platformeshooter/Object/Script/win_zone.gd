extends Area2D

func _on_body_entered(body: Node2D) -> void:
	load_next_level()

func load_next_level() -> void:
	var current_level = get_tree().current_scene.name
	var level_number = current_level.substr(5, current_level.length())
	
	var next_level_number = int(level_number) + 1
	var next_level_name = "level_" + str(next_level_number) + ".tscn"
	var path = "res://Level/" + next_level_name
	
	# Vérifier si le fichier de niveau existe
	if ResourceLoader.exists(path):
		get_tree().change_scene_to_file(path)
	else:
		get_tree().change_scene_to_file("res://GUI/VictoireScene.tscn")
