extends Node

const KEY_AUDIO_ENABLED := "audioEnabled"
const KEY_CASE_SENSITIVE_GAMEPLAY := "caseSensitiveGameplay"


var _audio_enabled:bool = true
var _case_sensitive_gameplay_enabled:bool = true

func _init() -> void:
	_load_settings()


func _load_settings() -> void:
	_audio_enabled = SaveManager.get_value(KEY_AUDIO_ENABLED, true)
	_case_sensitive_gameplay_enabled = SaveManager.get_value(KEY_CASE_SENSITIVE_GAMEPLAY, true)

var audio_enabled: bool:
	get:
		return _audio_enabled
	set(value):
		if value != _audio_enabled:
			SaveManager.set_value(KEY_AUDIO_ENABLED, value)
			_audio_enabled = value

var case_sensitive_gameplay_enabled: bool:
	get:
		return _case_sensitive_gameplay_enabled
	set(value):
		if value != _case_sensitive_gameplay_enabled:
			SaveManager.set_value(KEY_CASE_SENSITIVE_GAMEPLAY, value)
			_case_sensitive_gameplay_enabled = value
