extends CharacterBody2D

var hp=200.0;
var max_hp=200.0;
var is_being_moved:bool = false;
var has_exited_from_splitting_area=true;

var is_stopped:bool=false;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_set_scale()
	_set_hp_label()
	$CPUParticles2D.gravity.y = -200.0
	$CPUParticles2D.self_modulate=LevelManager.initial_modulate

	
func _set_scale() -> void:
	var scale_val:float=sqrt(hp/max_hp)
	var scale_vector:Vector2=Vector2(scale_val,scale_val);
	
	scale=scale_vector
	
	$CPUParticles2D.scale=scale_vector
	$CPUParticles2D.scale_amount_max=scale_val
	$CPUParticles2D.scale_amount_min=scale_val
	$CollisionShape2D.scale=scale_vector
	$CPUParticles2D.lifetime=scale_val
	
		
func set_particles_gravity(_direction:Vector2) -> void:
	if(!is_being_moved):
		$CPUParticles2D.gravity.y = _direction.y
		$CPUParticles2D.gravity.x = _direction.x
	

func _set_hp_label() -> void:
	$HPLabel.text=str(ceil(hp*10)/10.0)
# Called every frame. 'delta' is the elapsed time since the previous frame.
var frame:int=0;

func _process(delta: float) -> void:
	
	if(is_being_moved && !is_stopped):
		$CPUParticles2D.gravity.x = velocity.x
		$CPUParticles2D.gravity.y = velocity.y
		
		hp-=delta*20.0;
		if(frame % 10 == 0):
			_set_scale();
			_set_hp_label();
			
		if(hp<0.0):
			disappear();
	
		var collision=move_and_collide((velocity)*delta);
		
		if(collision):
			velocity=velocity.bounce(collision.get_normal())
			
			
			#playing one of collisionsounds
			if(randi() % 2  == 0):
				$CollisionsSound1.volume_db=hp/randf_range(16.0,18.0)-35;
				$CollisionsSound1.play(1.1)
			else:
				$CollisionsSound2.volume_db=hp/randf_range(16.0,18.0)-35;
				$CollisionsSound2.play(1.5)
				
				
	
	frame+=1;

func disappear() -> void:
	is_stopped=false;
	$HPLabel.visible=false
	set_physics_process(false);
	velocity=Vector2.ZERO
	is_being_moved=false
	$CPUParticles2D.emitting=false
	$DisappearTimer.start()
	
func split_into_half(area_pos:Vector2,rotate_deg:float) -> void:
	$FireSplittingSound.play(0.1);
	
	var player=get_parent();
	
	player.add_fire(area_pos,hp,velocity,rotate_deg);
	
	disappear()
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	if(area is SplitArea):
		if(has_exited_from_splitting_area):
			split_into_half(area.position,area.rotate_fire_degrees);
	elif(area is World_Boundary):
		disappear()
		play_disappear_sound()
	elif(area is TargetBlock):
		area.burn(hp);
		disappear();
		
		
func _on_disappear_timer_timeout() -> void:
	queue_free()


func _on_area_2d_area_exited(area: Area2D) -> void:
	if(area is SplitArea):
		has_exited_from_splitting_area=true;



func play_disappear_sound() -> void:
	$DisappearSound.play(0.2)
	
func _on_hitbox_area_entered(area: Area2D) -> void:
	disappear()
	play_disappear_sound()
	


func _on_hitbox_collision_with_physics_blocks(force: Vector2) -> void:
	if(!is_stopped):
		velocity+=force/hp;


func _on_hitbox_health_helper_take(_hp: float) -> void:
	hp+=_hp;
	_set_scale();
	_set_hp_label();

func stop() -> void:
	is_stopped=true
	
func resume() -> void:
	is_stopped=false
	
