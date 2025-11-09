class_name EndlessRunnerGameController extends GameController

@export var _text_manager:TextManager

var _wave_column_queue:Array[CrowdColumn] = []

func _reset() -> void:
	_text_manager.reset()
	super._reset()

func _restart() -> void:
	_text_manager.reset()
	
	super._reset()

func _start():
	_wave_column_queue = _screen_view.get_crowd_columns(0)
	super._start()

## Handles what happens when an existing column desspawns:
func _process_new_column_spawned(new_column:CrowdColumn) -> void:
	
	# TODO: Should we check state here?
	
	# Append to the wave queue
	_wave_column_queue.append(new_column)
	_screen_view.render_char_in_column(new_column)

func _process_existing_column_despawned(column:CrowdColumn) -> void:
	
	# Check for loss
	if len(_wave_column_queue) != 0 && column == _wave_column_queue[0]:
		_process_game_over()
	
	# Pop the front of the queue
	_wave_column_queue.pop_front()

## Handles what happens when the game receives a letter input.
func _process_letter_input(letter_input:String):
	if _state != State.READY && _state != State.PLAYING:
		return
	
	# Determine if it's the correct input
	if letter_input != _text_manager.get_currently_selected_char():
		# TODO: Handle the incorrect input here
		return
	
	# Update the state
	if _state == State.READY:
		_start()
	_text_manager.advance_selected_char()
	
	# Update the visuals
	advance_wave()

## Advances the wave by one column.
func advance_wave():
	
	print("WAVE COLUMN QUEUE: ", _wave_column_queue)
	
	var next_column:CrowdColumn = _wave_column_queue.pop_front()
	next_column.stand_up()
	_screen_view.check_for_camera_snap(next_column)

## Handles the game's game-over sequence.
func _process_game_over():
	if _state != State.PLAYING:
		return
	
	# Update the state
	_state = State.GAMEOVER
	
	# Update the visuals
	_screen_view.stop()
	await get_tree().create_timer(1).timeout
	_popups.show_game_over_menu(_restart)
