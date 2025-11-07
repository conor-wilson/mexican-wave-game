class_name EndlessRunnerScreenView extends ScreenView

const LETTER_ROW_INDEX:int = 5
const STARTING_CAMERA_SPEED:float = 200
const CAMERA_ACCELERATION:float = 5

@onready var crowd: Crowd = $Crowd

# TODO: Maybe this belongs in the game controller?
var letter_queue:String
var wave_column_queue:Array[CrowdColumn] = []

## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset()

## Populates the crowd with the provided letters. Here, it fills the letter row
## with the first few letters (a number equal to the number of crowd members), 
## and adds the rest of the letters to the letter queue.
func populate_letters(new_letter_queue:String) -> void:
	letter_queue = new_letter_queue
	for column in wave_column_queue:
		column.get_person_at_index(LETTER_ROW_INDEX).give_letter(_pop_letter_from_queue())

## Resets the game visuals to the very beginning state. Does not reuse any
## existing visual components (eg: deletes any existing crowd members instead of
## reusing them).
func reset() -> void:
	
	# TODO: Fix the reset mechanic when restarting the game
	
	# Reset the crowd
	wave_column_queue = []
	crowd.reset()
	
	super.reset()

## Starts the game visuals.
func start() -> void:
	# Update the camera
	game_camera.start_auto_scrolling(Vector2.RIGHT, STARTING_CAMERA_SPEED, CAMERA_ACCELERATION)

## Returns the letter-holding person in the next column of the wave.
func get_next_person_in_wave() -> Person:
	return wave_column_queue[0].get_person_at_index(LETTER_ROW_INDEX)

## Advances the wave by one column.
func advance_wave():
	wave_column_queue.pop_front().stand_up()

## Pops the first letter from the letter queue. Returns an empty string if there
## are no more letters in the queue.
func _pop_letter_from_queue() -> String:
	
	if len(letter_queue) == 0:
		return ""
	
	var letter:String = letter_queue[0]
	letter_queue = letter_queue.substr(1)
	return letter

## Triggered when a new column is spawned in the crowd.
func _on_crowd_new_column_spawned(column:CrowdColumn) -> void:
	
	# Setup the new Column's sign visuals
	column.get_person_at_index(LETTER_ROW_INDEX).give_letter(_pop_letter_from_queue())
	
	# Append to the wave queue
	wave_column_queue.append(column)

## Triggered when a column exits the screen.
func _on_crowd_column_exited_screen(column:CrowdColumn) -> void:
	
	# Check for loss
	if column == wave_column_queue[0]:
		game_camera.stop_auto_scrolling() # TODO: Should this be somewhere else?
		loss.emit()
	
	# Shift the crowd over by one
	column.queue_free()
	crowd.spawn_new_column()
