extends Node2D

var fire_scene:PackedScene=preload("res://scenes/Fire/fire.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func stop() -> void:
	for child in get_children():
		child.stop()

func resume() -> void:
	for child in get_children():
		child.resume()
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func shoot(vel:Vector2) -> void:
	$Fire.velocity=vel;
	$Fire.is_being_moved=true;
	
	
func add_fire(_position:Vector2,_hp:float,_velocity:Vector2,rotate_deg:float) -> void:
	for i in range(-1,2,2):
		var fire_instance=fire_scene.instantiate();
		
		fire_instance.position=_position;
		fire_instance.hp=_hp/2.0;
		fire_instance.velocity=_velocity.rotated(rotate_deg*3.14/180*i);
		fire_instance.has_exited_from_splitting_area=false;
		fire_instance.is_being_moved=true;
		
		call_deferred("add_child",fire_instance)
