extends GPUParticles2D

@onready var timer: Timer = $Timer

func _on_timer_timeout() -> void:
	queue_free()  # Destroy missile when it reaches target
