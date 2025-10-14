class_name GameManagerClass
extends Node


var score : int = 0

func increase_score() -> void:
	var label : Label = $"/root/MainScene/GameOverMenu/ScoreLabel"
	score+=1
	label.text = "Enemies killed : "+str(score)
	

func display_game_over(display :bool) -> void :
	var game_over_menu : Control = get_tree().get_first_node_in_group("game_over")
	game_over_menu.visible = display
	if display :
		Engine.time_scale=0.0

func restart() -> void :
	get_tree().reload_current_scene()
	Engine.time_scale=1.0
	score =0
	
		
func quit() -> void :
	get_tree().quit()
