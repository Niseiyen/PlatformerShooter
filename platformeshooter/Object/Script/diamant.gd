extends Area2D

@onready var game_manager: Node = %GameManager
@export var diamantValue: int = 10

func _on_body_entered(body: Node2D) -> void:
	game_manager.add_point(diamantValue)
	queue_free()
