extends Area2D

signal collision_with_physics_blocks(force:Vector2);
signal health_helper_take(hp:float)
var magnetic_components=[];


func apply_force(_position:Vector2,_power:float,_id:float) -> void:
	magnetic_components.append([_id,_position,_power])
	print(magnetic_components)
	
func delete_force(_id:float) -> void:
	for i in range(len(magnetic_components)):
		if(magnetic_components[i][0] == _id):
			magnetic_components.pop_at(i)
			break;
	print(magnetic_components)

func take_health(health:float) -> void:
	health_helper_take.emit(health)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for el in magnetic_components:
		collision_with_physics_blocks.emit(global_position.direction_to(el[1]).normalized()*el[2]*delta/max(10.0,global_position.distance_squared_to(el[1]))*100000)
	
