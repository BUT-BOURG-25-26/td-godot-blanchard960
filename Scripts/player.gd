class_name Player
extends Node3D
var healthbar


@export var move_speed:float = 5
@export var health: int = 5
@export var max_health : int = 5

@onready var animation_tree: AnimationTree = $characterMedium/AnimationTree

var move_inputs: Vector2



func _ready() -> void:
	healthbar = $SubViewport/HealthBar
	healthbar.max_value = max_health
	healthbar.value = health

func _process(delta:float) -> void:
	if Input.is_action_just_pressed("damage_player"):
		health -= 1
		healthbar.update(health)
	

func _physics_process(delta: float) -> void:
	read_move_inputs()
	move_inputs *= move_speed * delta
	animation_tree.set("parameters/conditions/isIdle", move_inputs == Vector2.ZERO)
	animation_tree.set("parameters/conditions/isRunning",move_inputs != Vector2.ZERO)
	
	var velocity = Vector3(move_inputs.x, 0.0, move_inputs.y)
	
	if  velocity != Vector3.ZERO:
		var look_at_point = global_position + (velocity*5.0)
		look_at(look_at_point)
		
	if move_inputs != Vector2.ZERO:
		global_position += velocity
	return

func read_move_inputs():
	move_inputs.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	move_inputs.y = Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
	move_inputs = move_inputs.normalized()
	return

func take_damage(damage : int)-> void:
	health -= damage
	if (health ==0):
		GameManager.display_game_over(true)
	healthbar.update(health)
