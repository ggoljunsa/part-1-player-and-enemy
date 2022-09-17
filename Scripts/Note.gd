extends Area2D

const SPAWN_LEFT = -400
const TARGET_X_LEFT = 0
const DIST_TO_TARGET_L = TARGET_X_LEFT - SPAWN_LEFT
const LEFT_LANE_SPAWN = Vector2(SPAWN_LEFT, 0)

#child of child note
const SPAWN_RIGHT = 400
const TARGET_X_RIGHT = 0
const DIST_TO_TARGET_R = SPAWN_RIGHT - TARGET_X_RIGHT
const RIGHT_LANE_SPAWN = Vector2(SPAWN_RIGHT, 0)+LEFT_LANE_SPAWN

var speed = 0
var hit = false
var lane_memorize = 0

var note = load("res://Scenes/Note.tscn")
var instance

func _ready():
	pass


func _physics_process(delta):
	if !hit:
		#if lane_memorize == 0:
		position.x += speed * delta
		if position.x > 100:
			queue_free()
			get_parent().reset_combo()
		#elif lane_memorize == 2:
		#	position.x -= speed * delta
			

	else:
		#if lane_memorize == 0:
		$Node2D.position.x -= speed * delta
		#else:
		#	$Node2D.position.x += speed * delta
		

# 0번으로 initialize을 한다. 즉 이 child의 child는 2로 initilize를 해야 한다.
func initialize(lane):
	if lane == 0:
		#lane_memorize = 0
		$AnimatedSprite.frame = 0
		position = LEFT_LANE_SPAWN
		speed = DIST_TO_TARGET_L / 2.0
		#instance = note.instance()
		#instance.initialize(2)
		#add_child(instance)
	#elif lane == 2:
	#	lane_memorize = 2
	#	$AnimatedSprite.frame = 2
	#	position = RIGHT_LANE_SPAWN
	#	speed = DIST_TO_TARGET_R / 2.0
	else:
		printerr("Invalid lane set for note: " + str(lane))
		return
	
	


func destroy(score):
	$CPUParticles2D.emitting = true
	$AnimatedSprite.visible = false
	$Timer.start()
	hit = true
	if score == 3:
		$Node2D/Label.text = "GREAT"
		$Node2D/Label.modulate = Color("f6d6bd")
	elif score == 2:
		$Node2D/Label.text = "GOOD"
		$Node2D/Label.modulate = Color("c3a38a")
	elif score == 1:
		$Node2D/Label.text = "OKAY"
		$Node2D/Label.modulate = Color("997577")


func _on_Timer_timeout():
	queue_free()
