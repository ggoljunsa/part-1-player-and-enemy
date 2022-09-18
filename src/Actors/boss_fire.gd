extends KinematicBody2D

export (float) var max_health = 1
onready var health = max_health
export var speed = 50

func _set_health():
	var prev_health = health - 1
	health = prev_health
	if health <= 0:
		queue_free()

func shoot():
	position.x -= speed

func _on_Area2D_area_entered(area: Area2D) -> void:
	_set_health()
