@abstract
class_name GamePopup extends Control # Popup class already exists

var _close_all_popups_logic:Callable

# Must be called before popup is shown or hidden - this allows it to close other popups when opened.
func init(close_all_popups_logic:Callable) -> void:
	_close_all_popups_logic = close_all_popups_logic

# Closes all other popups and shows this popup.
func _close_all_popups_and_show_this_popup() -> void:
	_close_all_popups_logic.call()
	show()
