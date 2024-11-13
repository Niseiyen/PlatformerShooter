extends Area2D

@onready var game_manager: Node = $"../../GameManager"
@export var diamantValue: int = 10

func _on_body_entered(body: Node2D) -> void:
	print("Diamant +10!")
	game_manager.point += diamantValue
	queue_free()
