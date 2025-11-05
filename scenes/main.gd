extends Node2D

@export var mexican_wave_typing_game_scene:PackedScene


func _on_endless_runner_button_pressed() -> void:
	SceneSwitcher.queue_switch_scene(SceneSwitcher.endless_runner_game)
