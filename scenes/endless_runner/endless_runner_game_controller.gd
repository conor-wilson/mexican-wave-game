class_name EndlessRunnerGameController extends GameController

@export var sample_letter_queue:String = ""

## Resets the game to the very beginning state. Does not reuse any existing
## visuals (eg: deletes any existing crowd members instead of reusing them).
func reset():
	super.reset()
	screen_view.populate_letters(sample_letter_queue)

## Handles what happens when the game receives a letter input.
func _process_letter_input(letter_input:String):
	if state != State.READY && state != State.PLAYING:
		return
	
	# Determine if it's the correct input
	var next_person:Person = screen_view.get_next_person_in_wave()
	if next_person == null:
		push_error("ScreenView.get_next_person_in_wave() returned a null person")
		return
	if letter_input != next_person.letter:
		# TODO: Handle the incorrect input here
		return
	
	# If this is the first correct input, start the game
	if state == State.READY:
		start()
	
	# Update the visuals
	screen_view.advance_wave()

## Handles the game's game-over sequence.
func _process_game_over():
	if state != State.PLAYING:
		return
	
	state = State.GAMEOVER
	await get_tree().create_timer(1).timeout
	popups.show_game_over_menu()
