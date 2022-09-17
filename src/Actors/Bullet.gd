extends Sprite

export var speed = Vector2(80, 0)
var dir 

func _ready():
	dir = Global.direction
	scale = Vector2(.5, .5) 

func _physics_process(delta):
	position  += dir * speed


func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()
