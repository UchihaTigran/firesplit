extends Control

signal resume;


func _on_button_button_down() -> void:
	print("click")
	resume.emit()


func _on_button_2_button_down() -> void:
	get_tree().reload_current_scene();


func _on_button_3_button_down() -> void:
	var scene = load("res://scenes/UI/menu.tscn").instantiate();
	
	
	SceneSwitcher.switch_to_scene(scene);
