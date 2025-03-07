extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_gauche: RayCast2D = $rayCastGauche
@onready var ray_cast_droite: RayCast2D = $rayCastDroite
@onready var ray_cast_ground_droite: RayCast2D = $rayCastGroundDroite
@onready var ray_cast_ground_gauche: RayCast2D = $rayCastGroundGauche
@onready var game_manager: Node = %GameManager
@onready var monster_dead: AudioStreamPlayer2D = $MonsterDead

@onready var timer: Timer = $Timer
@onready var hit_zone: Area2D = $hitZone
@onready var bullet_hit_zone: Area2D = $BulletHitZone

@export var speed = 60
@export var max_health: int = 1
@export var ennemiePointValue: int = 3

var health: int = max_health  # Santé actuelle
var direction = 1
var isDead: bool = false
var can_change_direction = true 

func _ready():
	health = max_health

func _process(delta):
	if !isDead:
		if ray_cast_droite.is_colliding() and can_change_direction:
			direction = -1
			animated_sprite_2d.flip_h = false
			disable_direction_change_for_a_moment()

		elif ray_cast_gauche.is_colliding() and can_change_direction:
			direction = 1
			animated_sprite_2d.flip_h = true
			disable_direction_change_for_a_moment()

		if (!ray_cast_ground_droite.is_colliding() or !ray_cast_ground_gauche.is_colliding()) and can_change_direction:
			direction = -direction
			animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h
			disable_direction_change_for_a_moment()

		# Déplacer l'ennemi
		position.x += direction * speed * delta

# Fonction pour infliger des dégâts
func take_damage(amount: int) -> void:
	if isDead:
		return

	health -= amount

	# Change la couleur du sprite pour indiquer les dégâts
	flash_red()

	if health <= 0:
		die()

# Fonction pour tuer l'ennemi
func die() -> void:
	animated_sprite_2d.play("death")
	monster_dead.play()
	hit_zone.queue_free()
	bullet_hit_zone.queue_free()
	isDead = true
	game_manager.add_point(ennemiePointValue)
	timer.start()

func _on_timer_timeout() -> void:
	queue_free()

func disable_direction_change_for_a_moment() -> void:
	can_change_direction = false
	await get_tree().create_timer(0.2).timeout
	can_change_direction = true

# Fonction pour faire clignoter l'ennemi en rouge
func flash_red() -> void:
	animated_sprite_2d.modulate = Color(1, 0, 0)
	await get_tree().create_timer(0.2).timeout 
	animated_sprite_2d.modulate = Color(1, 1, 1)
