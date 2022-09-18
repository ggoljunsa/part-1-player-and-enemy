extends KinematicBody2D

var velocity = Vector2(-1, 0)
export var gravity = 30
export var speed = 300

func _physics_process(delta: float) -> void:
	var collision_info = move_and_collide(velocity.normalized() * delta * speed)
	position.y += gravity




func _on_Area2D_area_entered(area: Area2D) -> void:
	queue_free()
