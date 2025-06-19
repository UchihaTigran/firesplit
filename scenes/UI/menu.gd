extends Control

var menu_item_scene=preload("res://scenes/UI/Menu/menu_item.tscn");
var modulate_color:Color=Color(0,0.2,0.8);
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	modulate=Color(0,0,0);
	
	var tween = get_tree().create_tween();
	tween.tween_property(self,"modulate",modulate_color,1.0)
	
	for level in len(LevelManager.levels):
		var menu_item=menu_item_scene.instantiate();
		menu_item.level_id=level+1;
		$ScrollContainer/VBoxContainer.add_child(menu_item)

	
