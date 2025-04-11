extends BaseMissile

func _ready():
	super._ready()
	# player missile spawns crosshair also
	crosshair = crosshair_scene.instantiate()
	crosshair.position = target_pos  # Place it at the target location
	get_parent().add_child(crosshair)  # Add it to the game (not the missile)

func _physics_process(delta: float) -> void:
	var next_pos = position + direction * resource.speed * delta
	# ray cast ahead
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(position, next_pos)
	query.collide_with_areas = true
	query.collide_with_bodies = false
	query.collision_mask = 4
	query.exclude = [self]
	var result = space_state.intersect_ray(query)
	
	if result and result.collider:
		position = target_pos
		set_physics_process(false)
		set_process(false)
		explode()
		return
		
	position = next_pos
