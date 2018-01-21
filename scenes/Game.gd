extends Node


func _ready():
	set_process(true)

func _process(delta):
	var actors = get_tree().get_nodes_in_group("actors")
	for actor in actors:
		if(actor.has_method("get_pos")):
			var pos = actor.get_pos()
			var width= Globals.get("display/width")
			var height = Globals.get("display/height")

			var new_pos = pos
			if(pos.x > width):
				new_pos.x = pos.x - width
			elif(pos.x < 0):
				new_pos.x = pos.x + width
			if(pos.y > height):
				new_pos.y = pos.y - height
			elif(pos.y < 0):
				new_pos.y = pos.y + height

			if (new_pos != pos):
				actor.set_pos(new_pos)
	if(get_tree().get_nodes_in_group("asteroids").size()==0):
		victory()

func victory():
	state.win = true
	get_tree().change_scene("res://scenes/Aftergame.tscn")