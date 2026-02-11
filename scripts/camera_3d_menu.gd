extends Camera3D

var origin_position = position
var intensity = 0.05

func _process(_delta: float) -> void:
	var position_x = origin_position.x + randf_range(-intensity, intensity)
	var position_y = origin_position.y + randf_range(-intensity, intensity)
	var position_z = origin_position.z + randf_range(-intensity, intensity)
	position = Vector3(position_x, position_y, position_z)
	
