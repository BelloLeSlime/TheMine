extends Node3D

@onready var main := $".."
@onready var wall1 := $SubViewportContainer/SubViewport/Wall
@onready var wall2 := $SubViewportContainer/SubViewport/Wall2
@onready var quit_button := $Node2D/Quit
@onready var red_flash := $Node2D/RedFlash
@onready var node_2d := $Node2D
@onready var camera := $SubViewportContainer/SubViewport/Camera3D

func _on_enter_pressed() -> void:
	for i in range(100):
		node_2d.position.x += 5
		camera.origin_position.z += 0.005
		camera.origin_position.x -= 0.005
		await get_tree().process_frame
		$Timer.start()

func _process(_delta: float) -> void:
	wall1.position.y += 0.3
	wall2.position.y += 0.3
	if wall1.position.y >= 20:
		wall1.position.y -= 20
	if wall2.position.y >= 20:
		wall2.position.y -= 20
	
	if quit_button.is_hovered():
		red_flash.visible = true
	else:
		red_flash.visible = false

func _on_timer_timeout() -> void:
	$ColorRect.visible = true
	$Timer2.start()

func _on_timer_2_timeout() -> void:
	main.start_intro()
