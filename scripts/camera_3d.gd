extends Camera3D

@export var bob_speed := 8.0
@export var bob_amount := 0.05

var bob_time := 0.0
var original_position: Vector3

func _ready():
	original_position = position

func apply_headbob(is_moving: bool, delta: float, is_sprinting: bool):
	var speed := bob_speed
	if is_sprinting:
		speed = bob_speed * 2
	
	var amount := bob_amount
	if is_sprinting:
		amount = bob_amount * 2
	
	if is_moving:
		bob_time += delta * speed
		position.y = original_position.y + sin(bob_time) * amount
	else:
		bob_time = 0.0
		position.y = lerp(position.y, original_position.y, delta * 10.0)
