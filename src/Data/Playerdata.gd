extends Node

signal player_died

var deaths := 0 setget set_deaths

func reset() -> void:
	deaths = 0

func set_deaths(value: int) -> void:
	deaths = value
	emit_signal("player_died")
	
