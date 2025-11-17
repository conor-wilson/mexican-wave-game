@abstract
class_name Popups
extends CanvasLayer

@export var _ready_screen: Control
@export var _hud: Control
@export var game_over_menu: GameOverMenu

## Resets the popups to the start-of-game state
func reset():
	_hide_all()
	_ready_screen.show()

## Hides all the popups.
func _hide_all():
	for child in get_children():
		if child is Control:
			child.hide()
			
func _setup_all():
	game_over_menu.init(_hide_all)

## Shows the in-game HUD screen.
func start():
	_setup_all()
	_hide_all()
	_hud.show()

## Shows the ready screen
func show_ready_screen():
	_hide_all()
	_ready_screen.show()

## Shows the in-game HUD
func show_hud():
	_hide_all()
	_hud.show()
