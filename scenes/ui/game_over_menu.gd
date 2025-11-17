class_name GameOverMenu extends GamePopup

@export var _retry_button:Button
@export var _score_text:Label
@export var _high_score_text:Label

const SCORE_LABEL_PREFIX := "Score: "
const SCORE_HIGH_LABEL_PREFIX := "Best: "

# Opens the popup, connecting up the provided button functionality.
func open_popup(retry_button_func:Callable, score:int, highscore: int):
	_score_text.text = SCORE_LABEL_PREFIX + str(score)
	_high_score_text.text = SCORE_HIGH_LABEL_PREFIX + str(highscore)
	if !_retry_button.pressed.is_connected(retry_button_func):
		_retry_button.pressed.connect(retry_button_func)
	show()
