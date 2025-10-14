class_name Enemy
extends CharacterBody3D

@export var move_speed:float = 3
var player : Player
var look_at_position
@onready var gameManager : GameManager = $"/root/GameManager"



func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	look_at_position = player.global_position

func _physics_process(delta: float) -> void:
	
	var move = Vector3(player.global_position.x-global_position.x,0.0,player.global_position.z-global_position.z).normalized()
	velocity = move * move_speed
	
	velocity.y = get_gravity().y
	
	look_at_position.y = position.y
	look_at(look_at_position)
	
	move_and_slide()
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider is Player:
			(collider as Player).take_damage(1)
			queue_free()
			
func destroy() -> void:
	print("incrementKill")
	gameManager.incrementKill()
	queue_free()
