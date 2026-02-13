extends CharacterBody2D

var input_x := 0.0
var input_y := 0.0

func _on_timer_timeout() -> void:
	input_x = Input.get_axis("q", "d") * 7000
	input_y = Input.get_axis("z", "s") * 7000
	velocity = Vector2(input_x, input_y)
	if velocity.length() > 0:
		$Bip.play()
	move_and_slide()
