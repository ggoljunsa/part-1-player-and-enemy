extends KinematicBody2D

var velocity = Vector2(-1, 0)
var speed = 500

func _physics_process(delta: float) -> void:
	var collision_info = move_and_collide(velocity.normalized() * delta * speed)


func _on_Area2D_area_entered(area: Area2D) -> void:
	queue_free()


func _on_VisibilityEnabler2D_screen_exited() -> void:
	queue_free()
