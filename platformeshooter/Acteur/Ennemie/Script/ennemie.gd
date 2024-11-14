extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_gauche: RayCast2D = $rayCastGauche
@onready var ray_cast_droite: RayCast2D = $rayCastDroite
@onready var ray_cast_ground_droite: RayCast2D = $rayCastGroundDroite
@onready var ray_cast_ground_gauche: RayCast2D = $rayCastGroundGauche
@onready var game_manager: Node = %GameManager

@onready var timer: Timer = $Timer
@onready var hit_zone: Area2D = $hitZone
@onready var bullet_hit_zone: Area2D = $BulletHitZone

const SPEED = 60
var direction = 1
@export var ennemiePointValue: int = 3

var isDead: bool = false

func _process(delta):
	if !isDead:
		# Vérification des collisions des raycasts gauche et droite
		if ray_cast_droite.is_colliding():
			direction = -1
			animated_sprite_2d.flip_h = false
		elif ray_cast_gauche.is_colliding():
			direction = 1
			animated_sprite_2d.flip_h = true

		# Vérification des raycasts pour le sol
		if !ray_cast_ground_droite.is_colliding() or !ray_cast_ground_gauche.is_colliding():
			direction = -direction
			animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h  

		position.x += direction * SPEED * delta

# Fonction pour tuer l'ennemi
func die() -> void:
	animated_sprite_2d.play("death")
	hit_zone.queue_free()
	bullet_hit_zone.queue_free()
	isDead = true
	game_manager.add_point(ennemiePointValue)
	timer.start()

func _on_timer_timeout() -> void:
	queue_free()
