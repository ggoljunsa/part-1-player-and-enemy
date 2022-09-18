extends Button

export(String, FILE) var next_scene_path := "res://src/Levels/LevelTemplate.tscn"

func _on_button_up() -> void:
	get_tree().paused = false
	get_tree().change_scene(next_scene_path)
