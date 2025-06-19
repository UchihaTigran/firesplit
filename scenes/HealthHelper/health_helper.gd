extends Area2D

@export var hp:float=20.0;

func _on_area_entered(area: Area2D) -> void:
	area.take_health(hp);
	$GPUParticles2D.emitting=false;
	set_physics_process(false)
	$disappearTimer.start();


func _on_disappear_timer_timeout() -> void:
	queue_free();
