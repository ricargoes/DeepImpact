extends Node

func _ready():
	set_process_input(true)
	Music.play()

func _input(event):
	if(event.is_action_pressed("continue")):
		begin_game()
	elif(event.is_action_pressed("exit")):
		get_tree().quit()

func begin_game():
	get_tree().change_scene("res://scenes/Game.tscn")
