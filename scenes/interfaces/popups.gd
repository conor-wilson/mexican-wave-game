class_name Popups extends CanvasLayer

signal retry

@export var ready_screen: Control
@export var hud: Control
@export var game_over_menu: Control
@export var game_over_menu_retry_button: Button

## Resets the popups to the start-of-game state
func reset():
	hide_all()
	ready_screen.show()

## Connects all the signals from the various popups.
func connect_all_signals():
	
	# Connect the game-over menu signals
	game_over_menu_retry_button.retry.connect(_on_retry_button_pressed)

## Hides all the popups.
func hide_all():
	for child in get_children():
		if child is Control:
			child.hide()

## Shows the in-game HUD screen.
func start():
	hide_all()
	hud.show()

## Shows the ready screen
func show_ready_screen():
	hide_all()
	ready_screen.show()

## Shows the in-game HUD
func show_hud():
	hide_all()
	hud.show()

## Shows the game-over menu.
func show_game_over_menu():
	hide_all()
	game_over_menu.show()

## Triggers when the game-over menu's retry button is pressed.
func _on_retry_button_pressed() -> void:
	retry.emit()
