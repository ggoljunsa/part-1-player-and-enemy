extends "res://src/Actors/Actor.gd"


export (float) var max_health = 1
onready var health = max_health

func _ready() -> void:
	
	set_physics_process(false)
	_velocity.x = -speed.x

func _set_health():
	var prev_health = health - 1
	health = prev_health
	if health <= 0:
		queue_free()

func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	
	if is_on_wall():
		_velocity.x *= -1.0
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
	
func _on_Area2D_area_entered(area: Area2D) -> void:
	_set_health()

