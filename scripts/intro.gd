extends Node2D

var elevator_vanished = false
var speaked = false
var passed_second_area = false

func _process(_delta: float) -> void:
	if $CamusIntro in $Area1.get_overlapping_bodies():
		$Camera2D.position.y = 324.0
		if elevator_vanished and not $Timer.time_left:
			$Timer.start()
			if not $Glitch.playing:
				$Glitch.play()
				$Camera2D/AnimatedSprite2D.visible = true
			
		$Elevator.visible = not elevator_vanished
	elif $CamusIntro in $Area2.get_overlapping_bodies():
		if not passed_second_area:
			$Timer2.start()
		passed_second_area = true
		$Camera2D.position.y = 324.0 + 648.0
		if not elevator_vanished:
			elevator_vanished = true
	
	if $CamusIntro in $Area3.get_overlapping_bodies() and not speaked:
		pass

func _on_timer_timeout() -> void:
	$"..".start_game()

func _on_timer_2_timeout() -> void:
	$Rezero.play()
