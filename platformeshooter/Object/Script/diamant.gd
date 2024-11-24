extends Area2D

@onready var game_manager: Node = %GameManager
@export var diamantValue: int = 10
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _on_body_entered(body: Node2D) -> void:
	audio_stream_player_2d.play()
	game_manager.add_point(diamantValue)
	queue_free()
