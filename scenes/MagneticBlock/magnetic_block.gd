extends Area2D

@export var power:float=80;
var id:float;

func _ready() -> void:
	id=randf()
	
	
	
func _on_area_entered(area: Area2D) -> void:
	print("in")
	area.apply_force(global_position,power,id)
	
func _on_area_exited(area: Area2D) -> void:
	print("out")
	area.delete_force(id)
