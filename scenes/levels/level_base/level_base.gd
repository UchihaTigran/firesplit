extends Node2D
class_name level_base
#pushing/pulling zones (circular) ,<-----------/
#health helpers <------/
#fire destroyers  <-----------------/
#wind zones

@export var start_pos:Marker2D;
@export var level_id:int=1;
# Called when the node enters the scene tree for the first time.

var initial_modulate;
var game_state="shooting"
var mouse_drag_start_pos:Vector2;
var mouse_drag_end_pos:Vector2;
var should_appear:bool=false;

var frame:int = 0;

var can_shoot=false;

var game_stopped:bool = false;

func _ready() -> void:
	$Player/Fire.position=start_pos.position;
	initial_modulate=modulate;
	
	if(should_appear):
		_appear()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if(!game_stopped):
		frame+=1;
		
		if(frame % 10):
			var player_amount=$Player.get_child_count();
			
			if(player_amount == 0):
				if($LosingTimer.is_stopped()):
					$LosingTimer.start()
		
		if(game_state == "shooting" and can_shoot):
			mouse_drag_end_pos=get_global_mouse_position();
			
			if(Input.is_action_just_pressed("mouseLeft")):
				$DirectionLine2D.visible=true;
				$DegreesLabel.visible=true;
				
				mouse_drag_start_pos=get_global_mouse_position()
				
			elif(Input.is_action_just_released("mouseLeft")):
				$DirectionLine2D.visible=false;
				$DegreesLabel.visible=false;
				
				
				var distance:float = mouse_drag_end_pos.distance_to(mouse_drag_start_pos)
				
				if(distance > 100.0):
					$Player.shoot((mouse_drag_start_pos-mouse_drag_end_pos).normalized()*100.0);
			
					game_state="watching";
				
			if(mouse_drag_start_pos && $DirectionLine2D.visible):
				var _dir = (mouse_drag_start_pos-mouse_drag_end_pos).normalized()*500;
				$Player/Fire.set_particles_gravity(_dir)
				
				$DirectionLine2D.points[0]=mouse_drag_start_pos
				$DirectionLine2D.points[1]=mouse_drag_end_pos
				
				var arrow_rotation=rad_to_deg(mouse_drag_start_pos.angle_to_point(mouse_drag_end_pos))
				$DegreesLabel.text=str(floor((arrow_rotation+180)*10)/10.0);
				$DegreesLabel.position=mouse_drag_start_pos;
				
				$DirectionLine2D/Arrow.position=mouse_drag_start_pos;
				$DirectionLine2D/Arrow.rotation_degrees=arrow_rotation-90;
				
func winning_animation() -> void:
	$WinningParticles.emitting=true
	
	$WinningSound.play()
	
	_disappear()
	
	
	
func _on_losing_timer_timeout() -> void:
	var target_blocks_count=$TargetBlocks.get_child_count()
	print("target_blocks",target_blocks_count)
	if(target_blocks_count == 0):
		winning_animation();
	else:
		get_tree().reload_current_scene()

func _appear() -> void:
	
	modulate=Color(0,0,0);
	
	var tween=get_tree().create_tween();
	tween.tween_property(self,"modulate",initial_modulate,1.0)
	
func _disappear() -> void:
	var tween=get_tree().create_tween();
	tween.tween_property(self,"modulate",Color(0,0,0),1.0)
	
func _on_winning_particles_finished() -> void:
	#adding a level if this level is the last
	if(level_id == LevelManager.data.unlocked_level):
		LevelManager.add_unlocked_level()
	
	#changing the main scene
	var scene_resource = load("res://scenes/UI/GameEndUI/game_end.tscn")  # or preload
	var scene_instance = scene_resource.instantiate()
	
	
	scene_instance.current_level=level_id;
	scene_instance.modulate_color=initial_modulate
	

	SceneSwitcher.switch_to_scene(scene_instance)
	
	


	
func _on_stop_page_resume() -> void:
		
	$Camera2D/StopPage.visible=false;
	$Camera2D/StopButton.visible=true;
	set_physics_process(true)
	game_stopped=false
	can_shoot=false;
	$StartTimer.start();
	$Player.resume()
	

func _on_stop_button_pause_button() -> void:
	if(!$LosingTimer.is_stopped() || !$WinningParticles.emitting):
		$Camera2D/StopPage.visible=true;
		$Camera2D/StopButton.visible=false;
		$Player.stop()
		set_physics_process(false)
		game_stopped=true


func _on_start_timer_timeout() -> void:
	can_shoot=true;
