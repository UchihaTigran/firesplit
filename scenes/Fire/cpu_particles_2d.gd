extends CPUParticles2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self_modulate=LevelManager.initial_modulate
