extends Node2D

#permet de référencer votre scène enemy au sein de votre script
@export var enemy_scene: PackedScene  = preload("res://Scenes/Enemy.tscn")



func _on_timer_timeout():
	# Spawner votre enemy
	print("test")
	var enemy = enemy_scene.instantiate()
	get_parent().add_child(enemy)
