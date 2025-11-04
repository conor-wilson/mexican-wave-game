class_name CrowdMember extends Node2D

@export var letter:String
@onready var label: Label = $Label
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $StaticBody2D/CollisionShape2D

var sitting_pos:Vector2

const STANDING_DIFF:Vector2 = Vector2(0, -32)

func _ready() -> void:
	reset()

func reset():
	
	label.text = letter
	
	if letter == " ":
		sprite_2d.hide()
	
	collision_shape_2d.disabled = true
	
	sitting_pos = position

func stand_up(letter_input:String) -> bool:
	
	collision_shape_2d.disabled = false
	
	if letter_input == letter:
		position = sitting_pos + STANDING_DIFF
		return true
	
	return false


func sit_down():
	collision_shape_2d.disabled = true
	position = sitting_pos
