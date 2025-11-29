class_name PauseMenu extends GamePopup

@export var _retry_button:Button
@export var _home_button:Button

@export var _close_button:Button

var _game_controller:GameController

# Opens the popup, connecting up the provided button functionality.
func open_popup(game_controller:GameController = null):
	_game_controller = game_controller
	_setup_buttons()
	AudioManager.play_audio(AudioManager.music_tune, 0, false, 0)
	AudioManager.play_audio(AudioManager.music_beats, 0.5, false)
	show()

func _setup_buttons():
	if _retry_button != null and !_retry_button.pressed.is_connected(_restart_button_clicked):
		_retry_button.pressed.connect(_restart_button_clicked)
	if _home_button != null and !_home_button.pressed.is_connected(_quit_button_clicked):
		_home_button.pressed.connect(_quit_button_clicked)
	if _close_button != null and !_close_button.pressed.is_connected(_close_button_clicked):
		_close_button.pressed.connect(_close_button_clicked)

func _quit_button_clicked():
	_game_controller.quit()

func _restart_button_clicked():
	_game_controller.restart()

func _close_button_clicked():
	if _game_controller != null:
		_game_controller.unpause()
		AudioManager.play_audio(AudioManager.music_tune, 1, false, 0.25)
		AudioManager.play_audio(AudioManager.music_beats, 1, false)
	hide()
