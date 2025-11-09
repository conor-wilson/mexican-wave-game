class_name CrowdColumnPool extends Node

# TODO: Add comments here

var _crowd_column_scene:PackedScene
var _columns:Array[CrowdColumn] = []

func _init(initial_size:int, crowd_column_scene:PackedScene) -> void:
	
	_crowd_column_scene = crowd_column_scene
	
	for i in range(0, initial_size):
		_expand_pool()

func _expand_pool() -> CrowdColumn:
	var new_column = _crowd_column_scene.instantiate() as CrowdColumn
	new_column.despawn()
	_columns.append(new_column)
	return new_column

func get_unused_crowd_column() -> CrowdColumn:
	
	for column in _columns:
		if !column.active:
			return column
	
	return _expand_pool()
