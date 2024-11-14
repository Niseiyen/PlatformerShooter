extends CharacterBody2D

@onready var player_animation: AnimatedSprite2D = $playerAnimation
@onready var invincibility_timer: Timer = $InvincibilityTimer 
@onready var timer: Timer = $Timer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var hearts_container: HBoxContainer = $"../CanvasLayer/heartsContainer"

const SPEED = 138.0
const JUMP_VELOCITY = -300.0

@export var maxHealth = 3
@export var currentHealth: int = maxHealth
var is_invincible: bool = false
var blink_interval: float = 0.1 
var invincibility_duration: float = 2.0

func _ready() -> void:
	invincibility_timer.wait_time = blink_interval
	invincibility_timer.one_shot = false
	invincibility_timer.connect("timeout", Callable(self, "_on_invincibility_timeout"))
	
	timer.wait_time = 0.6
	timer.one_shot = true
	
	if hearts_container.has_method("setup_hearts"):
		hearts_container.call("setup_hearts", maxHealth)

func _process(delta: float) -> void:
	if currentHealth == 0:
		invincibility_timer.stop()
		print("Died")
		Engine.time_scale = 0.5 
		collision_shape_2d.disabled = true  
		player_animation.visible = true 
		
		if timer.is_stopped():  
			timer.start()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	# Gérer le saut.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Obtenir la direction de l'entrée et gérer le mouvement/la décélération.
	var direction := Input.get_axis("move_left", "move_right")
	
	if Input.is_action_just_pressed("move_down") and is_on_floor():
		position.y += 1.5
	
	if direction > 0:
		player_animation.flip_h = true
	elif direction < 0:
		player_animation.flip_h = false
		
	if is_on_floor():
		if direction == 0:
			player_animation.play("idle")
		else:
			player_animation.play("run")
	else:
		player_animation.play("jump")
		
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()			# Ajouter la gravité.
		

func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()

func _start_invincibility_effect():
	is_invincible = true
	player_animation.visible = false  
	invincibility_timer.start() 

	await get_tree().create_timer(invincibility_duration).timeout 
	_stop_invincibility_effect()

func _stop_invincibility_effect():
	is_invincible = false
	player_animation.visible = true  
	invincibility_timer.stop() 

func _on_invincibility_timeout():
	player_animation.visible = not player_animation.visible  

func _on_hurt_box_area_entered(area: Area2D) -> void:
	if area.name == "hitZone" and not is_invincible:
		currentHealth -= 1
		print("Vie restante:", currentHealth)
		_start_invincibility_effect()
	if area.name == "KillZone" and not is_invincible:
		currentHealth = 0
		
		if hearts_container.has_method("update_hearts"):
			hearts_container.call("update_hearts", currentHealth)
