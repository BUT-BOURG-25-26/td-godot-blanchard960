extends Node3D

#permet de référencer votre scène enemy au sein de votre script
@export var enemy_scene: PackedScene
@export var distance_from_player : int = 10
var player : Player
var rng = RandomNumberGenerator.new()



func _on_timer_timeout():
	player = get_tree().get_first_node_in_group("player")
	var x = rng.randi_range(-distance_from_player, distance_from_player)
	var z = rng.randi_range(-distance_from_player, distance_from_player)
	if( -1 > (player.global_position.x-x)+(player.global_position.z-z) || (player.global_position.x-x)+(player.global_position.z-z) > 1) :
		# Spawner votre enemy
		var enemy = enemy_scene.instantiate()
		enemy.global_position = player.global_position +Vector3(x,0.0,z)
	
		get_parent().add_child(enemy)
	
