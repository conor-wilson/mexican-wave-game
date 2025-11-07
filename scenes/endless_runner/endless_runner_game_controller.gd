class_name EndlessRunnerGameController extends Node2D # TODO: Should this extend an "interface"?

@export var sample_letter_queue:String = ""
@export var input_system: InputSystem # TODO: Should this be a global class?
@export var screen_view: EndlessRunnerScreenView # TODO: Change to superclass
@export var popups: EndlessRunnerPopups # TODO: Change to superclass

enum State {
	READY,
	PLAYING,
	OVER,
}
var state:State

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await setup()
	reset()

## Sets up the modular components by waiting for them to be ready, and then
## connecting all their signals to the correct functions.
func setup() -> void:
	await wait_for_ready_components()
	connect_all_signals()

func reset(reuse_existing_crowd:bool = false) -> void:
	
	# Reset the state
	state = State.READY
	
	# Reset the visuals
	screen_view.reset(sample_letter_queue, reuse_existing_crowd)
	popups.reset()

## Checks to see if the modular components are ready. If they are not, the
## function waits until they are. Pushes errors if any of them are undefined.
func wait_for_ready_components() -> void:
	
	# Connect the InputSystem signals
	if input_system != null:
		if !input_system.is_node_ready():
			await input_system.ready
	else:
		push_error("no InputSystem defined")
	
	# Connect the ScreenView signals
	if screen_view != null:
		if !screen_view.is_node_ready():
			await screen_view.ready
	else:
		push_error("no ScreenView defined")
	
	# Connect the Popup signals:
	if popups != null:
		if !popups.is_node_ready():
			await popups.ready
	else:
		push_error("no Popups defined")

## Connects all the signals from the modular components.
func connect_all_signals():
	
	# Connect the InputSystem signals
	input_system.letter_input_received.connect(_on_input_system_letter_input_received)

	# Connect the ScreenView signals
	screen_view.loss.connect(_on_screen_view_loss)
	
	# Connect the Popup signals:
	popups.retry.connect(_on_popups_retry)

## Starts the EndlessRunner game
func start():
	if state != State.READY:
		return
	
	# Update the state
	state = State.PLAYING
	
	# Update the visuals
	screen_view.start()
	popups.show_go()

## Triggered when the InputSystem signals that a letter input has been received.
func _on_input_system_letter_input_received(letter_input:String) -> void:
	if state != State.READY && state != State.PLAYING:
		return
	_process_letter_input(letter_input)

## Triggered when the ScreenView signals that a loss has occurred.
func _on_screen_view_loss() -> void:
	if state != State.PLAYING:
		return
	_process_game_over()

## Handles what happens when the game receives a letter input.
func _process_letter_input(letter_input:String):
	if state != State.READY && state != State.PLAYING:
		return
	
	# Determine if it's the correct input
	if letter_input != screen_view.get_next_letter():
		# TODO: Handle the incorrect input
		return
	
	# If this is the first correct input, start the game
	if state == State.READY:
		start()
	
	# Update the visuals
	screen_view.stand_up_next_person_column()

## Handles the game's game-over sequence.
func _process_game_over():
	if state != State.PLAYING:
		return
	
	state = State.OVER
	await get_tree().create_timer(1).timeout
	popups.show_game_over_menu()

## Triggers when the the Popups signal that the player wants to retry.
func _on_popups_retry() -> void:
	reset()
