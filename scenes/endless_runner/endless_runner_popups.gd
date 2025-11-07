class_name EndlessRunnerPopups extends Popups

@onready var go_screen: Label = $GoScreen
@onready var go_screen_hide_timer: Timer = $GoScreen/HideTimer

## Shows the "GO" text temporarily before displaying the HUD.
func start():
	hide_all()
	
	# Temporarily show the GoScreen
	go_screen.show()
	go_screen_hide_timer.start()
	await go_screen_hide_timer.timeout
	go_screen.show()
	
	# Now show the HUD
	super.start()
