extends KinematicBody2D

const rockpath = preload("res://src/Actors/rsc/rock.tscn")
var attack_flag = false
export (float) var max_health = 5
onready var health = max_health

#raycast는 마스크를 환경과 같게!

var is_moving_left = true

var gravity = 10
var velocity = Vector2.ZERO

var speed = 50

func _ready() -> void:
	$HealthBar.on_max_health_updated(max_health)
	$HealthBar.assign_color(health)
	$AnimatedSprite.play("idle")

#func _process(delta: float) -> void:
	#move_character()
	#detect_turn_around()
	

func _set_health():
	var prev_health = health - 1
	health = prev_health
	$HealthBar.on_health_updated(health)
	$HealthBar.assign_color(health)
	if health <= 0:
		queue_free()


func move_character():
	if is_moving_left:
		velocity.x = -speed
	else:
		velocity.x = -speed
	
	velocity.y += gravity
	
	velocity = move_and_slide(velocity, Vector2.UP)

func detect_turn_around():
	if not $RayCast2D.is_colliding() and is_on_floor():
		is_moving_left = !is_moving_left
		scale.x = -scale.x

func shoot():
	$AnimatedSprite.play("shoot")
	var rock = rockpath.instance()
	get_parent().add_child(rock)
	rock.position = $Position2D.global_position





func _on_Timer_timeout() -> void:
	#print_debug("timeout")
	if attack_flag:
		shoot()


func _on_Area2D_area_entered(area: Area2D) -> void:
	_set_health()



func _on_VisibilityEnabler2D_screen_entered() -> void:
	attack_flag = true
	#print_debug("enter")


func _on_VisibilityEnabler2D_screen_exited() -> void:
	attack_flag = false
	#print_debug("exit")
	$AnimatedSprite.play("idle")
