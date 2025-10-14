class_name Player
extends Node3D
var healthbar

@export var vfx_impact_sceen: PackedScene
@export var move_speed:float = 5
@export var health: int = 5
@export var max_health : int = 5

var move_inputs: Vector2



func _ready() -> void:
	healthbar = $SubViewport/HealthBar
	healthbar.max_value = max_health
	healthbar.value = health

func _process(delta:float) -> void:
	if Input.is_action_just_pressed("damage_player"):
		health -= 1
		healthbar.update(health)
	if (Input.is_action_just_pressed("attack")):
		attack()

func _physics_process(delta: float) -> void:
	read_move_inputs()
	move_inputs *= move_speed * delta
	if move_inputs != Vector2.ZERO:
		global_position += Vector3(move_inputs.x, 0.0, move_inputs.y)
	return

func read_move_inputs():
	move_inputs.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	move_inputs.y = Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
	move_inputs = move_inputs.normalized()
	return

func take_damage(damage : int)-> void:
	health -= damage
	if (health ==0):
		get_tree().reload_current_scene()
	healthbar.update(health)
	
func attack() -> void:
	# Récupère la caméra dans la scène
	var camera = get_tree().get_first_node_in_group("camera")

	# Permet de récupérer la position de la souris a l'écran (ou du tap en mobile)
	var screen_pos = get_viewport().get_mouse_position()

	# Permet de convertir la position 2D en position de départ 3D & d'arrivée 3D
	var from = camera.project_ray_origin(screen_pos)
	var to = from + camera.project_ray_normal(screen_pos) * 1000.0

	# Permet de récupérer l'espace du world actuel pour créer un raycast
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(from, to)

	# La fonction qui permet vraiment de savoir avec quoi on collisionne
	var result = space_state.intersect_ray(query)

	if result:
		print(result.position)
		var vfx = vfx_impact_sceen.instantiate()
		get_parent().add_child(vfx)
		vfx.position = result.position
		vfx.emit()
