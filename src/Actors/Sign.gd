extends KinematicBody2D



func _on_Area2D_body_entered(body: Node) -> void:
	Global.signtouch += 1


func _on_Area2D_body_exited(body: Node) -> void:
	Global.signleave += 1
	$Area2D.queue_free()
