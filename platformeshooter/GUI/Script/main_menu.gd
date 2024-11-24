extends Control

func _on_jouer_pressed() -> void:
	get_tree().change_scene_to_file("res://Level/level_1.tscn")

func _on_quitter_pressed() -> void:
	get_tree().quit()
