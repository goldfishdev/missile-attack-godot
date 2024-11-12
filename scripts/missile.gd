extends Node2D

var speed = 150

var target = Vector2.ZERO
var dist
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dist = position.distance_to(target)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if position != target:
		position = position.move_toward(target, speed * delta)
	elif $Area2D.scale <= Vector2(2.5, 2.5):
		explode(delta)
		if $CPUParticles2D:
			$CPUParticles2D.emitting = false
	else:
		queue_free()

func explode(delta) -> void:
	$Area2D.scale += Vector2(1.25, 1.25) * delta


func _on_cpu_particles_2d_finished() -> void:
	queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.queue_free()
		get_tree().reload_current_scene()
