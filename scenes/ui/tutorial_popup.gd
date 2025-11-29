class_name TutorialPopup extends GamePopup

const PERSON = "Person"
const WAVE_DELAY = 1
const DELAY_BETWEEN_PEOPLE_IN_WAVE = 0.1

@export var _wave_people: Array[Control] = []
@export var _sleeping_people: Array[Control] = []
@export var _sad_people: Array[Control] = []

@export var _close_button:Button


func _ready() -> void:
	_run_wave_people_gif()
	_run_sleeping_people_gif()
	_run_sad_people_gif()
	if _close_button != null and !_close_button.pressed.is_connected(hide):
		_close_button.pressed.connect(hide)

func _run_wave_people_gif():
	_assign_text_to_group("Win", _wave_people)
	await get_tree().create_timer(WAVE_DELAY).timeout
	for i in range(_wave_people.size()):
		_wave_people[i].get_node(PERSON).stand_up()
		await get_tree().create_timer(DELAY_BETWEEN_PEOPLE_IN_WAVE).timeout
	_run_wave_people_gif()

func _run_sleeping_people_gif():
	_waddle(_sleeping_people)
	_assign_text_to_group("Sleep", _sleeping_people)
	_sleeping_people[2].get_node(PERSON).go_to_sleep()

func _run_sad_people_gif():
	_waddle(_sad_people)
	for i in range(_sad_people.size()):
		_sad_people[i].get_node(PERSON).become_upset()

func _assign_text_to_group(text:String, group:Array[Control]):
	var count = min(group.size(), text.length())
	for i in range(count):
		group[i].get_node(PERSON).give_letter(text[i])

func _waddle(group:Array[Control]):
	for i in range(group.size()):
		group[i].get_node(PERSON).waddle(randf_range(0, 4),
		randf_range(0.2, 2),
		randf_range(2, 5))
