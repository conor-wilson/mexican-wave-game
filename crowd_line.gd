extends Node2D

@export var crowd_members:Array[CrowdMember]

var current_crowd_member_index:int

func _ready() -> void:
	
	reset()
	

func reset():
	current_crowd_member_index = -1
	for crowd_member in crowd_members:
		crowd_member.sit_down()
	
	
func execute_wave(time_between:float) -> void:
	for crowd_member in crowd_members:
		crowd_member.stand_up(crowd_member.letter)
		await get_tree().create_timer(time_between).timeout
		crowd_member.sit_down()

func _unhandled_input(event: InputEvent) -> void:
	
	if event.is_pressed() && event is InputEventKey:
		var key_event := event as InputEventKey
		var letter_input = PackedByteArray([key_event.unicode]).get_string_from_utf8()
		
		var correct:bool = crowd_members[current_crowd_member_index+1].stand_up(
			letter_input
		)
		
		if correct:
			print("Correct Letter: ", letter_input)
			crowd_members[current_crowd_member_index].sit_down()
			current_crowd_member_index += 1
			
			if current_crowd_member_index+1 == len(crowd_members):
				print("SUCCESS!")
				current_crowd_member_index = -1
				await get_tree().create_timer(0.3).timeout
				reset()
				execute_wave(0.1)
			else:
				print("Next letter: ", crowd_members[current_crowd_member_index+1].letter)
		else:
			print("Incorrect Letter: ", letter_input)
	
	
