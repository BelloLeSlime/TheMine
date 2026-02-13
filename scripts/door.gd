extends MeshInstance3D

var opened = false
var opening = false

func _process(_delta: float) -> void:
	for body in $Area3D.get_overlapping_bodies():
		if body.name == "Camus":
			if Input.is_action_just_pressed("e") and not opening:
				if opened:
					close()
				else:
					open()

func open():
	opened = true
	opening = true
	for _i in range(100):
		position.x += 0.035
		await get_tree().process_frame
	opening = false

func close():
	opened = false
	opening = true
	for _i in range(100):
		position.x -= 0.035
		await get_tree().process_frame
	opening = false
