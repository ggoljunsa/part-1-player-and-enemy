extends Sprite

export var speed = Vector2(80, 80)
export (float) var max_health = 1
onready var health = max_health
var dir


func _ready():
	dir = Global.direction
	scale = Vector2(.5, .5)

func _physics_process(delta):
	position += dir * speed


func _on_VisibilityNotifier2D_screen_exited() -> void:
	
	queue_free()


func _set_health(value):
	var prev_health = health - 1
	health = prev_health
	if health <= 0:
		pass
		queue_free()


func _on_Area2D_area_entered(area: Area2D) -> void:
	#print_debug(true)
	queue_free()
