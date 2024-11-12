extends Node2D

const BASE_SPEED = 30
var speed = BASE_SPEED
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += speed * delta
	speed += 2


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("base"):
		area.get_parent().explode()
	elif area.is_in_group("missile"):
		queue_free()
