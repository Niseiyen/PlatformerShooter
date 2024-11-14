extends MarginContainer

@onready var game_manager: Node = %GameManager
@onready var nombre_point: Label = $PanelContainer/MarginContainer/HBoxContainer/NombrePoint

func _process(delta: float) -> void:
	nombre_point.text = str(game_manager.point)
