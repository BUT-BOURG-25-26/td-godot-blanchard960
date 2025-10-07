extends CharacterBody3D

@export var move_speed:float = 1
var player 

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
	var move = Vector3(player.global_position.x-global_position.x,0.0,player.global_position.z-global_position.z).normalized()
	velocity = move * move_speed
	move_and_slide()
