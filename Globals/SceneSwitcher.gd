extends Node

func switch_to_scene(scene_instance) -> void:
	get_tree().root.add_child(scene_instance)

	# (Optional) Remove current scene, if you're switching
	get_tree().current_scene.queue_free()
	get_tree().current_scene = scene_instance

func switch_to_file(file) -> void:
	get_tree().change_scene_to_file(file)
