extends KinematicBody2D

export (float) var max_health = 10
onready var health = max_health
const firepath = preload("res://src/Actors/boss_fire.tscn")
var attack_flag = false

func _ready() -> void:
	$AnimatedSprite.play("idle")


func _set_health():
	var prev_health = health - 1
	health = prev_health
	if health <= 0:
		queue_free()


func hit():
	$AttackDetector.monitoring = true

func end_of_hit():
	$AttackDetector.monitoring = false

func shoot():
	$AnimatedSprite.play("one_distance")
	var fire = firepath.instance()
	add_child(fire)
	fire.position = $Position2D.global_position
	print_debug("shoot")



func _on_PlayerDetector_area_entered(area: Area2D) -> void:
	$AnimatedSprite.play("melee")


func _on_AttackDetector_body_entered(body: Node) -> void:
	get_tree().reload_current_scene()
	print_debug("reload")


func _on_Area2D_area_entered(area: Area2D) -> void:
	_set_health()
	print_debug("sethealth")

func _on_playerdetectorone_area_entered(area: Area2D) -> void:
	shoot()
	print_debug("shoot")


func _on_attackdetectorone_body_entered(body: Node) -> void:
	get_tree().reload_current_scene()
	print_debug("reload2")


func _on_Timer_timeout() -> void:
	if attack_flag:
		shoot()
