extends Area2D

@export var coinValue: int = 1
@onready var game_manager: Node = %GameManager
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _on_body_entered(body: Node2D) -> void:
	game_manager.add_point(coinValue)
	audio_stream_player_2d.play()
	queue_free()
