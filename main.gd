extends Node2D

@export var mexican_wave_typing_game_scene:PackedScene


func _on_mexican_wave_game_pressed() -> void:
	SceneSwitcher.queue_switch_scene(SceneSwitcher.mexican_wave_typing_game_scene)

func _on_ball_bounce_game_pressed() -> void:
	SceneSwitcher.queue_switch_scene(SceneSwitcher.ball_bounce_spelling_game_scene)

func _on_crab_game_pressed() -> void:
	SceneSwitcher.queue_switch_scene(SceneSwitcher.crab_game)

func _on_endless_runner_game_pressed() -> void:
	SceneSwitcher.queue_switch_scene(SceneSwitcher.endless_runner_game)
