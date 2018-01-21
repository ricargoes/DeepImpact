extends Node

func _ready():
	set_process_input(true)
	if State.active_scene == null:
		State.active_scene = self

func _input(event):
	if(event.is_action_pressed("continue")):
		State.change_scene("res://scenes/InGame.tscn")
	elif(event.is_action_pressed("exit")):
		get_tree().quit()
