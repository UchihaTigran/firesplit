extends Button


var level_id:int;
var is_in_unlocked_levels:bool=false;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.text="Level" + str(level_id)
	if(LevelManager.data.unlocked_level >= level_id):
		is_in_unlocked_levels=true;
		$UnlockPrev.visible=false;
		


func _on_button_down() -> void:
	if(is_in_unlocked_levels):
		var scene=load(LevelManager.levels[level_id-1]).instantiate();
		scene.should_appear=true;
		SceneSwitcher.switch_to_scene(scene)
