class_name GameManagerClass
extends Node


var nbkill : int = 0
@onready var label : Label = $"/root/MainScene/nbKill"

func _process(delta: float) -> void:
	if (label):
		label.text = str(nbkill)

func incrementKill() -> void:
	nbkill +=1


func display_game_over(display :bool) -> void :
	var game_over_menu : Control = get_tree().get_first_node_in_group("game_over")
	game_over_menu.visible = display
	if display :
		Engine.time_scale=0.0

func restart() -> void :
	get_tree().reload_current_scene()
	Engine.time_scale=1.0
	
		
func quit() -> void :
	get_tree().quit()
