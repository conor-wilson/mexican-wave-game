extends Node2D

const ROCK_SPEED:float = -300

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	$Rocks.position.x += ROCK_SPEED*delta
