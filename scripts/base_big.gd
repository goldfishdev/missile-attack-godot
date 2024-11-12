extends Node2D

@onready var player = get_node("../player")

var missile : PackedScene = preload("res://scenes/missile.tscn")

var target = Vector2.ZERO

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func shoot():
	target = player.global_position
	var sMissile = missile.instantiate()
	sMissile.target = target
	sMissile.position = $Marker2D.global_position
	get_parent().add_child(sMissile)

func explode() -> void:
	queue_free()

func _on_timer_timeout() -> void:
	shoot()
	var choose = randf()
	if choose > 0.5:
		$Timer.wait_time += randf() + 0.5
	else:
		$Timer.wait_time -= randf() - 0.5
