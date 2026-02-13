extends RigidBody3D

@export var SPEED = 1200

var sensitivity := 0.03
var twist_input := 0.0
var pitch_input := 0.0

@onready var twist_pivot := $Twist
@onready var pitch_pivot := $Twist/Pitch
@onready var camera := $Twist/Pitch/Camera3D
@onready var light := $Twist/Pitch/Camera3D/SpotLight3D
@onready var footsteps := $Footsteps
@onready var flashlight := $Flashlight

var lighted_on := false

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _process(delta: float) -> void:
	var input := Vector3.ZERO
	input.x = Input.get_axis("d", "q")
	input.z = Input.get_axis("s", "z")
	apply_central_force(twist_pivot.basis * input * SPEED * delta)
	
	twist_pivot.rotate_y(twist_input)
	pitch_pivot.rotate_x(pitch_input)
	pitch_pivot.rotation.x = clamp(
		pitch_pivot.rotation.x,
		-PI/2,
		PI/2
	)
	
	twist_input = 0.0
	pitch_input = 0.0
	
	if Input.is_action_just_pressed("right_click"):
		$Flashlight.play()
		lighted_on = not lighted_on
		if lighted_on:
			light.light_energy = 16
		else:
			light.light_energy = 0
	
	if Input.is_action_pressed("shift"):
		SPEED = 2400
	else:
		SPEED = 1200
	
	var is_moving := linear_velocity.length() > 0.1
	var is_sprinting := Input.is_action_pressed("shift") and is_moving
	camera.apply_headbob(is_moving, delta, is_sprinting)
	
	if is_moving:
		if is_sprinting:
			if footsteps.stream != load("res://assets/sounds/footstep_quicker.mp3"):
				footsteps.stream = load("res://assets/sounds/footstep_quicker.mp3")
		else:
			if footsteps.stream != load("res://assets/sounds/footstep.mp3"):
				footsteps.stream = load("res://assets/sounds/footstep.mp3")
		if not footsteps.playing:
			footsteps.play()
	else:
		if footsteps.playing:
			footsteps.stop()
	

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			twist_input = -event.relative.x * sensitivity
			pitch_input = -event.relative.y * sensitivity
			
