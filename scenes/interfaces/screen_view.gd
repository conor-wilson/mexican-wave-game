class_name ScreenView extends Node

signal loss

@export var game_camera: GameCamera

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset()

## Resets the game visuals to the very beginning state. Does not reuse any
## existing visual components (eg: deletes any existing crowd members instead of
## reusing them).
func reset() -> void:
	# Reset the camera
	game_camera.stop_auto_scrolling()

## Starts the game visuals.
func start() -> void:
	print_debug("start() function is unimplemented")
	pass

## Populates the crowd with the provided letters (whatever that might mean for 
## this game mode)
func populate_letters(new_letters:String):
	print_debug("populate_letters() function is unimplemented")
	pass

## Returns the central person in the next column of the wave.
func get_next_person_in_wave() -> Person:
	# TODO: Maybe there's a good generic way to implement this?
	print_debug("get_next_person_in_wave() function is unimplemented")
	return null

## Advances the wave by one column.
func advance_wave():
	# TODO: Maybe there's a good generic way to implement this?
	print_debug("get_next_person_in_wave() function is unimplemented")
	return null
