extends Node3D

#permet de référencer votre scène enemy au sein de votre script
@export var enemy_scene: PackedScene
@export var min_spawn_distance : int =5
@export var max_spawn_distance : int =10
var player : Player
var rng = RandomNumberGenerator.new()

func _on_timer_timeout():
	player = get_tree().get_first_node_in_group("player")
	
	var distance : int = rng.randi_range(min_spawn_distance, max_spawn_distance)
	
	var x = 1 + rng.randf_range(-1, 1)
	var z = 1 + rng.randf_range(-1, 1)
		
	var enemy = enemy_scene.instantiate()
	get_parent().add_child(enemy)
	enemy.position = player.global_position + (distance * Vector3(x,0.0,z).normalized())
