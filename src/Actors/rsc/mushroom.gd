extends KinematicBody2D

const chimpath = preload("res://src/Actors/rsc/chim.tscn")


export (float) var max_health = 5
onready var health = max_health

var velocity = Vector2.ZERO
var speed = 50
var timer = null
var chim_delay = 1
var can_shoot = true


func _ready() -> void:
	$HealthBar.on_max_health_updated(max_health)
	$HealthBar.assign_color(health)
	pass
	
func on_timeout_complete():
	can_shoot = true

func shoot():
	var chim = chimpath.instance()
	get_parent().add_child(chim)
	chim.position = $Position2D.global_position


func _set_health():
	var prev_health = health - 1
	health = prev_health
	$HealthBar.on_health_updated(health)
	$HealthBar.assign_color(health)
	if health <= 0:
		queue_free()


func _on_Timer_timeout() -> void:
	shoot()
	


func _on_Area2D_area_entered(area: Area2D) -> void:
	_set_health()


func _on_VisibilityEnabler2D_screen_entered() -> void:
	$Timer.start(1)


func _on_VisibilityEnabler2D_screen_exited() -> void:
	$Timer.stop()
