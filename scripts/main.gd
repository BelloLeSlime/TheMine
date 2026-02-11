extends Node3D

var game_preload := preload("res://scenes/game.tscn")
var intro_preload := preload("res://scenes/intro.tscn")

func start_intro():
	if has_node("Intro"):
		$Intro.queue_free()
	if has_node("Menu"):
		$Menu.queue_free()
	var intro = intro_preload.instantiate()
	add_child(intro)

func start_game():
	if has_node("Intro"):
		$Intro.queue_free()
	if has_node("Menu"):
		$Menu.queue_free()
	var game = game_preload.instantiate()
	add_child(game)
