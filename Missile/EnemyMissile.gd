extends BaseMissile

func _ready() -> void:
	super._ready()
	area2d.monitoring = true
	area2d.area_entered.connect(explosion_area_entered)

func _physics_process(delta: float) -> void:
	var delta_pos = direction * resource.speed * delta
	position += delta_pos
	if position.y > get_viewport_rect().size.y:
		explode()

func explosion_area_entered(_area: Area2D):
	super.call_deferred("explode")
