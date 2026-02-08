extends Node3D

@onready var main := $".."

func _on_enter_pressed() -> void:
	main.start_intro()
