extends Node3D

func _on_teleport_back_body_entered(body: Node3D) -> void:
	if body.name == "Camus":
		body.position.z = $TeleportPoint.global_position.z
		await get_tree().process_frame
		print(body.position.z)
