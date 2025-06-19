extends level_base

var colors=[
	Color(1.0,0.064,0.23),
	Color(0.0,0.75,0.93),
	Color(0.85,0.65,0.0)
]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()

var destination_color:Color=Color(1,1,1)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super(delta)
	modulate=lerp(modulate,destination_color,delta)
	

func _on_change_color_timer_timeout() -> void:
	destination_color=colors[randi() % 3];
