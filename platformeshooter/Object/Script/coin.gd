extends Area2D

@export var coinValue: int = 1
@onready var game_manager: Node = %GameManager

func _on_body_entered(body: Node2D) -> void:
	game_manager.add_point(coinValue)
	queue_free()
