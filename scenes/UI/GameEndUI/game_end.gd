extends Control

var current_level:int;
var modulate_color:Color;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	modulate=Color(0,0,0)
	var tween = get_tree().create_tween();
	tween.tween_property(self,"modulate",modulate_color,1.0)
	
	print(modulate_color)
	if(current_level == len(LevelManager.levels)):
		$Buttons/Panel.queue_free();
		$LastLevelLabel.visible=true

#replay
func _on_button_2_button_down() -> void:
	if(len(LevelManager.levels) >= current_level):
		disappearing_animation();
		$DisappearTimer3.start();
		

#next
func _on_button_button_down() -> void:
	if(len(LevelManager.levels) >= current_level+1):
		disappearing_animation()
		$DisappearTimer2.start();
		
		
		

func disappearing_animation() -> void:
	var tween = get_tree().create_tween();
	tween.tween_property(self,"modulate",Color(0,0,0),1.0)
	
#menu
func _on_button_3_button_down() -> void:
	disappearing_animation()
	$DisappearTimer.start();


func _on_disappear_timer_timeout() -> void:
	var scene=load("res://scenes/UI/menu.tscn").instantiate();
	
	scene.modulate_color=modulate_color
	
	SceneSwitcher.switch_to_scene(scene);


func _on_disappear_timer_2_timeout() -> void:
	var scene=load(LevelManager.levels[current_level]).instantiate();
		
	scene.should_appear=true;
		
	SceneSwitcher.switch_to_scene(scene)


func _on_disappear_timer_3_timeout() -> void:
	var scene=load(LevelManager.levels[current_level-1]).instantiate();
		
	scene.should_appear=true;
		
	SceneSwitcher.switch_to_scene(scene)
