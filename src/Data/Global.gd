extends Node2D


var score = 0
var combo = 0
var great = 0
var good = 0
var okay = 0
var missed = 0
var grade = "NA"

var direction = Vector2.RIGHT

export (float) var max_health = 5
onready var health = max_health

signal player_died
signal sign_touch
signal sign_leave

var deaths := 0 setget set_deaths
var signtouch := 0 setget set_sign
var signleave := 0 setget leave_sign

func reset() -> void:
	deaths = 0
	signtouch = 0
	signleave = 0

func set_deaths(value: int) -> void:
	deaths = value
	emit_signal("player_died")
	
func set_sign(value: int) -> void:
	signtouch = value
	emit_signal("sign_touch")
	
func leave_sign(value: int) -> void:
	signleave = value
	emit_signal("sign_leave")

func set_score(new):
	score = new
	if score > 250000:
		grade = "A+"
	elif score > 200000:
		grade = "A"
	elif score > 150000:
		grade = "A-"
	elif score > 130000:
		grade = "B+"
	elif score > 115000:
		grade = "B"
	elif score > 100000:
		grade = "B-"
	elif score > 85000:
		grade = "C+"
	elif score > 70000:
		grade = "C"
	elif score > 55000:
		grade = "C-"
	elif score > 40000:
		grade = "D+"
	elif score > 30000:
		grade = "D"
	elif score > 20000:
		grade = "D-"
	else:
		grade = "F"
		
