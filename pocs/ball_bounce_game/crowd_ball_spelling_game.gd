extends Node2D

@export var letter_dict:Dictionary[String, CrowdMember] = {}
@export var ball_scene:PackedScene


@onready var ball_spawn_point: Marker2D = $BallSpawnPoint

var ball:Ball = null

func _ready() -> void:
	reset()


func reset() -> void:
	pass


func process_correct_input(letter:String):
	print("Correct letter input: ", letter)
	letter_dict[letter].stand_up(letter)
	await get_tree().create_timer(0.2).timeout
	letter_dict[letter].sit_down()

func process_incorrect_input(letter:String):
	print("Incorrect letter input: ", letter)

func _unhandled_input(event: InputEvent) -> void:
	
	if event.is_pressed() && event is InputEventKey:
		var key_event := event as InputEventKey
		var letter_input = PackedByteArray([key_event.unicode]).get_string_from_utf8()
		
		if letter_dict.has(letter_input):
			process_correct_input(letter_input)
		else:
			process_incorrect_input(letter_input)
	

func spawn_new_ball():
	
	# Create the new ball
	var new_ball = ball_scene.instantiate() as Ball
	new_ball.position = ball_spawn_point.position
	add_child(new_ball)
	
	# Get rid of the old ball
	if ball != null:
		ball.queue_free()
	ball = new_ball
	
	# Apply some randomness to the ball
	var horizontal_force:float = randf_range(-1000, 1000)
	ball.apply_central_impulse(Vector2(horizontal_force, 0))
	

func _on_release_ball_button_pressed() -> void:
	spawn_new_ball()


func _on_back_button_pressed() -> void:
	SceneSwitcher.queue_switch_scene(SceneSwitcher.main_scene)
