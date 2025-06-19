extends Area2D
class_name TargetBlock;

@export var max_hp:float=10.0;
var hp;

func burn(damage:float) -> void:
	if(hp > 0.0):
		hp-=damage;
		set_hp()
		burn_animation();
		print(hp)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	hp=max_hp;
	set_hp()

func set_hp() -> void:
	if(hp <= 0.0):
		set_physics_process(false);
		$HPBar.visible=false;
		$TargetBlock.visible=false;
		
	$HPBar/HPBar.text=str(ceil(hp*10)/10.0);
	$HPBar/FullHP/HP.scale.x=hp/max_hp;
	
	
func burn_animation() ->void:
	$BurnAnimation.emitting=true;
	set_physics_process(false)
	$BurnSound.play()

func _on_burn_animation_finished() -> void:
	if(hp<=0.0):
		queue_free();

	
