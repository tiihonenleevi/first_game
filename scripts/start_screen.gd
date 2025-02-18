extends Control

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("start"):
		_on_start_button_pressed()

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
