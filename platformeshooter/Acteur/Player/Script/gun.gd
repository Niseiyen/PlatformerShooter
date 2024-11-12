extends Sprite2D

const BULLET = preload("res://Acteur/Player/Bullet.tscn")
@onready var marker_2d: Marker2D = $Marker2D

func _process(delta):
	# Rotation de l'arme vers la souris
	var mouse_position = get_global_mouse_position()
	var direction = (mouse_position - global_position).normalized()
	rotation = direction.angle()
	
	# Détection du clic gauche pour tirer une balle
	if Input.is_action_just_pressed("shoot"):
		shoot()

func shoot():
	# Instance de la balle et ajout à la scène
	var bullet_instance = BULLET.instantiate()
	bullet_instance.position = marker_2d.global_position  
	bullet_instance.rotation = rotation
	get_parent().add_child(bullet_instance)
