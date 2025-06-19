extends Node

var initial_modulate:Color=Color(1.0,1.0,1.0);

var levels=[
	"res://scenes/levels/level1/level_1.tscn",
	"res://scenes/levels/level2/level_2.tscn",
	"res://scenes/levels/level3/level_3.tscn",
	"res://scenes/levels/level4/level_4.tscn",
	"res://scenes/levels/level5/level_5.tscn",
	"res://scenes/levels/level6/level_6.tscn",
	"res://scenes/levels/level7/level_7.tscn",
	"res://scenes/levels/level8/level_8.tscn",
	"res://scenes/levels/level9/level_9.tscn",
	"res://scenes/levels/level10/level_10.tscn",
	"res://scenes/levels/level11/level_11.tscn",
]

var data={
	"unlocked_level":11
}


var save_path = "res://Globals/game_progress.save"

func _ready() -> void:
	load_progress();
	
	
func save_progress() -> void:
	var file = FileAccess.open(save_path,FileAccess.WRITE)
	if(file):
		file.store_var(data)
	
func load_progress() -> void:
	if(FileAccess.file_exists(save_path)):
		var file = FileAccess.open(save_path,FileAccess.READ)
		
		if(file):
			data = file.get_var()
	else:
		data = {
			"unlocked_level":11
		}
		save_progress()

func add_unlocked_level() -> void:
	data.unlocked_level+=1;
	save_progress();
