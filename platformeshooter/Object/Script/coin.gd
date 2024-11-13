extends Area2D

@onready var game_manager: Node = $"../../GameManager"
@export var coinValue: int = 3

func _on_body_entered(body: Node2D) -> void:
	print("Coin +1")
	game_manager.point += coinValue
	queue_free()
