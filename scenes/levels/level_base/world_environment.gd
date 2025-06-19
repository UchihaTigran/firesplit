extends WorldEnvironment

@export var var_intensity:float =0.8;
@export var var_strength:float =1.0;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	environment.glow_intensity=var_intensity;
	environment.glow_intensity=var_strength;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
