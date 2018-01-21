extends Node

func _ready():
	set_process_input(true)

func _input(event):
	if(event.is_action_pressed("continue")):
		get_tree().change_scene("res://scenes/Game.tscn")
	elif(event.is_action_pressed("exit")):
		get_tree().quit()
