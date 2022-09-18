extends Node2D


export (float) var max_health = 5
onready var health = max_health setget _set_health


func _on_Area2D_area_entered(area: Area2D) -> void:
	$HealthBar.on_max_health_updated(max_health)
	$HealthBar.assign_color(health)
	_set_health(1)


func _set_health(value):
	var prev_health = health - 1
	health = prev_health
	$HealthBar.on_health_updated(health)
	$HealthBar.assign_color(health)
	if health <= 0:
		queue_free()
