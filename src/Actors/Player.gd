extends KinematicBody2D

const FLOOR_NORMAL: = Vector2.UP

export var speed: = Vector2(400.0, 500.0)
export var gravity: = 3500.0

var _velocity: = Vector2.ZERO
var shoot_enable = false



export var stomp_impulse: = 600.0
onready var bullet = preload("res://src/Actors/Bullet.tscn")
var temp

var direction
func _ready() -> void:
	Global.health = Global.max_health
	$HealthBar.on_max_health_updated(Global.max_health)
	$HealthBar.assign_color(Global.health)
	$ATree.active = true
	#$ATree.process_mode = 0
	#$ATree.set("parameters/Shooting/current", 0)
	#$ATree.set("parameters/moving/current", 0)
	#$ATree.set("parameters/moving_2/current", 0)


func _physics_process(delta: float) -> void:
	shoot()
	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
	direction = get_direction()
	_velocity.y += gravity * delta
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
		
		
	var snap: Vector2 = Vector2.DOWN * 60.0 if direction.y == 0.0 else Vector2.ZERO
	_velocity = move_and_slide_with_snap(
		_velocity, snap, FLOOR_NORMAL, true
	)
	_velocity.y += gravity * delta
	
	if direction == Vector2.ZERO and abs(_velocity.y)<60:
		#print_debug("idle")
		nm_idle()
	if !is_on_floor():
		#print_debug("jump")
		nm_jump()
	
	
func get_direction() -> Vector2:
	if Input.get_action_strength("move_right"):
		$Sprite.scale.x = 1
		if is_on_floor():
			#print_debug("run")
			nm_run()
		Global.direction = Vector2.RIGHT
		#$Position2D.position.x *= abs($Position2D.position.x)
	if Input.get_action_strength("move_left"):
		$Sprite.scale.x = -1
		Global.direction = Vector2.LEFT
		if is_on_floor():
			#print_debug("run")
			nm_run()
		#$Position2D.position.x = abs($Position2D.position.x) * -1
	
	if Input.get_action_strength("move_up"):
		Global.direction = Vector2.UP
	
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if is_on_floor() and Input.is_action_just_pressed("jump") else 0.0)


func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2,
		is_jump_interrupted: bool
	) -> Vector2:
	var velocity: = linear_velocity
	velocity.x = speed.x * direction.x
	if direction.y != 0.0:
		velocity.y = speed.y * direction.y
	if is_jump_interrupted:
		pass#velocity.y = 0.0
	return velocity


func die() -> void:
	Global.deaths += 1
	queue_free()
	
func shoot():
	if Input.is_action_just_pressed('shoot_X') :
		$ATree.set("parameters/Shooting_ground/current", 0)
		$ATree.set("parameters/Shooting_ground_2/current", 0)
		if Global.direction == Vector2.UP:
			$ATree.set("parameters/Direction/current", 1)
			$ATree.set("parameters/s_direction/current", 1)
		else:
			$ATree.set("parameters/Direction/current", 0)
			$ATree.set("parameters/s_direction/current", 0)
		$ShootTimer.start(0.5)
		if Global.combo > 1:
			temp = bullet.instance()
			get_parent().add_child(temp)
			if Global.direction == Vector2.UP:
				$Position2D.position = Vector2(-8, -176)
			elif Global.direction == Vector2.LEFT:
				$Position2D.position = Vector2(-56, -120)
			elif Global.direction == Vector2.RIGHT:
				$Position2D.position = Vector2(56, -120)
			temp.global_position = $Position2D.global_position
	

func damage():
	#if invulnerability_timer.is_stopped():
	#invulnerability_timer.play()
	_set_health()
	

func _set_health():
	var prev_health = Global.health - 1
	Global.health = prev_health
	$HealthBar.on_health_updated(Global.health)
	$HealthBar.assign_color(Global.health)
	if Global.health <= 0:
		die()


func _on_InvulnerablilityTimer_timeout() -> void:
	modulate.a = 1; 
	$EnemyDetector.position = Vector2(0, 0)


func _on_EnemyDetector_area_entered(area: Area2D) -> void:
	modulate.a = 0.5;
	$EnemyDetector.position = Vector2(0, -6000)
	$InvulnerablilityTimer.start();
	damage()


func _on_ShootTimer_timeout() -> void:
	$ATree.set("parameters/Shooting_ground/current", 1)
	$ATree.set("parameters/Shooting_ground_2/current", 1)

func nm_run() -> void:
	$ATree.set("parameters/Jump/current", 0)
	#$ATree.set("parameters/Shooting_ground/current", 1)
	$ATree.set("parameters/ns_moving/current", 1)
	$ATree.set("parameters/up_moving/current", 1)
	$ATree.set("parameters/norm_moving/current", 1)

func nm_idle() -> void:
	$ATree.set("parameters/Jump/current", 0)
	#$ATree.set("parameters/Shooting_ground/current", 1)
	$ATree.set("parameters/ns_moving/current", 0)
	$ATree.set("parameters/up_moving/current", 0)
	$ATree.set("parameters/norm_moving/current", 0)

func nm_jump() -> void:
	$ATree.set("parameters/Jump/current", 1)
	#$ATree.set("parameters/Shooting_ground_2/current", 1)
	#$ATree.set("parameters/ns_direction/current", 0)


func _on_ItemDectector_area_entered(area: Area2D) -> void:
	Global.health += 1
	print_debug("detected")
	$HealthBar.on_health_updated(Global.health)
	$HealthBar.assign_color(Global.health)
	pass # Replace with function body.
