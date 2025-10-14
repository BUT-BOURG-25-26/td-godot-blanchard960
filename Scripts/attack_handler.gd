extends Node3D

@export var vfx_impact_sceen: PackedScene


func _process(delta :float) -> void:
	if (Input.is_action_just_pressed("attack")):
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
			get_parent().get_parent().add_child(vfx)
			vfx.position = result.position
			vfx.emit()
