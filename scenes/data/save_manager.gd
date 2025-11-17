extends Node

const FILE_PATH := "user://save.json"

var data:Dictionary

func _init() -> void:
	_load_game()
	
func set_value(key: String, value) -> void:
	var mark_dirty = false
	if value != get_value(key):
		mark_dirty = true # Needs to be set prior to set
	data[key] = value
	if mark_dirty:
		_save_game()

func get_value(key: String, default = null):
	return data.get(key, default)

func remove_value(key: String) -> void:
	if data.has(key):
		data.erase(key)
		_save_game()

func _save_game() -> void:
	var file := FileAccess.open(FILE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(data))

func _load_game() -> void:
	if not FileAccess.file_exists(FILE_PATH):
		return
	var file := FileAccess.open(FILE_PATH, FileAccess.READ)
	data = JSON.parse_string(file.get_as_text()) as Dictionary
