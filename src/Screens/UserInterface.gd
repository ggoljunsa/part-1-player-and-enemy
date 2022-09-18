extends Control

onready var scene_tree: = get_tree()
onready var pause_overlay: ColorRect = get_node("Pauseoverlay")
onready var signed_overlay: ColorRect = get_node("Dialogoverlay")
onready var pause_title: Label = get_node("Pauseoverlay/Title")

var paused: = false setget set_paused
var signed: = false setget set_signed
var leavesign: = true setget leave_sign

export var Path = ""
export var Count = ""


func _ready() -> void:
	Global.connect("player_died", self, "_on_Playerdata_Player_died")
	Global.connect("sign_touch", self, "_on_Playerdata_sign_touch")
	Global.connect("sign_leave", self, "_on_Playerdata_sign_leave")

	
func _on_Playerdata_Player_died() -> void:
	self.paused = true
	pause_title.text = "You died"
	
func _on_Playerdata_sign_touch() -> void:
	self.signed = true
	
func _on_Playerdata_sign_leave() -> void:
	self.leavesign = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		self.paused = not paused
		scene_tree.set_input_as_handled()

func set_paused( value: bool) -> void:
	paused = value
	scene_tree.paused = value
	pause_overlay.visible = value
	
func set_signed(value: bool) -> void:
	signed = value
	paused = value
	scene_tree.paused = value
	signed_overlay.visible = value
	
func leave_sign(value: bool) -> void:
	self.paused = value
	scene_tree.set_input_as_handled()
	

	
	
	
