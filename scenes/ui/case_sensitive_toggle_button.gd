extends ToggleIconButton
class_name CaseSensitiveToggleButton

func _get_toggle_value():
    return Settings.case_sensitive_gameplay_enabled

func _set_toggle_value(value):
    Settings.case_sensitive_gameplay_enabled = value