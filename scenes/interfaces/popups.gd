class_name Popups extends CanvasLayer

@export var ready_screen: Control
@export var hud: Control
@export var game_over_menu: GameOverMenu

## Resets the popups to the start-of-game state
func reset():
	hide_all()
	ready_screen.show()

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
func show_game_over_menu(retry_button_functionality:Callable):
	hide_all()
	game_over_menu.open_popup(retry_button_functionality)
