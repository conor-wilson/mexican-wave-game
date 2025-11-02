extends Node2D

@export var phrase:String

@export var crowd_member_scene:PackedScene
@export var spacing_between_crowd_members:int
@export var first_crowd_member_marker:Marker2D

var crowd_members:Array[CrowdMember]

var current_crowd_member_index:int


func _ready() -> void:
	
	reset()
	

func reset():
	
	# Reset all the variables
	crowd_members = []
	current_crowd_member_index = -1
	
	# Setup the crowd members
	var buffer:int = 0
	for letter in phrase:
		var new_crowd_member = crowd_member_scene.instantiate() as CrowdMember
		print(new_crowd_member)
		add_child(new_crowd_member)
		new_crowd_member.position = first_crowd_member_marker.position+Vector2(buffer, 0)
		new_crowd_member.letter = letter
		new_crowd_member.reset()
		crowd_members.append(new_crowd_member)
		buffer += spacing_between_crowd_members

func all_sit_down():
	for member in crowd_members:
		member.sit_down()

func execute_wave(time_between:float) -> void:
	for crowd_member in crowd_members:
		crowd_member.stand_up(crowd_member.letter)
		await get_tree().create_timer(time_between).timeout
		crowd_member.sit_down()

func process_correct_letter(letter:String):
	print("Correct Letter: ", letter)
	crowd_members[current_crowd_member_index].sit_down()
	current_crowd_member_index += 1
	
	if current_crowd_member_index+1 == len(crowd_members):
		print("SUCCESS!")
		current_crowd_member_index = -1
		await get_tree().create_timer(0.3).timeout
		all_sit_down()
		execute_wave(0.1)
	else:
		print("Next letter: ", crowd_members[current_crowd_member_index+1].letter)

func process_incorrect_letter(letter:String):
	print("Incorrect Letter: ", letter)
	

func _unhandled_input(event: InputEvent) -> void:
	
	if event.is_pressed() && event is InputEventKey:
		var key_event := event as InputEventKey
		var letter_input = PackedByteArray([key_event.unicode]).get_string_from_utf8()
		
		var correct:bool = crowd_members[current_crowd_member_index+1].stand_up(
			letter_input
		)
		
		if correct:
			process_correct_letter(letter_input)
		else:
			process_incorrect_letter(letter_input)
	
	
