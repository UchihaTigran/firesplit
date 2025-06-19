extends Panel

signal pause_button;


func _on_button_button_down() -> void:
	pause_button.emit()
