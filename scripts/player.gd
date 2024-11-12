extends CharacterBody2D

@onready var screen_size = get_viewport_rect().size

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var bomb : PackedScene = preload("res://scenes/bomb.tscn")
var can_shoot = true


func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("left", "right", "up", "down", -1.0)
	
	
	position.x = wrapf(position.x, 0, screen_size.x)
	
	if direction:
		velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO
	if can_shoot:
		$Label.text = "Ready!"
	else:
		$Label.text = str(snapped($Timer.time_left, 0.01))
	move_and_slide()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("shoot") and can_shoot:
		shoot()


func shoot() -> void:
	$Timer.start()
	can_shoot = false
	var dBomb = bomb.instantiate()
	dBomb.global_position = $Marker2D.global_position
	get_parent().add_child(dBomb)


func _on_timer_timeout() -> void:
	can_shoot = true
