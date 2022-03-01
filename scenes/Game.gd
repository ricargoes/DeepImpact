extends Node

func _ready():
	set_process(true)
	var n_asteroids = 2*State.level
	var asteroid_scene = load("res://scenes/BigAsteroid.tscn")
	for i in range(0,n_asteroids):
		var asteroid = asteroid_scene.instantiate()
		add_child(asteroid)

func _process(delta):
	var actors = get_tree().get_nodes_in_group("actors")
	for actor in actors:
		if(actor.has_method("get_position")):
			var pos = actor.get_position()
			var width = get_viewport().get_visible_rect().size.x
			var height = get_viewport().get_visible_rect().size.y

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
				actor.set_position(new_pos)
	if(get_tree().get_nodes_in_group("asteroids").size()==0):
		victory()

func victory():
	State.win = true
	get_tree().change_scene("res://scenes/Aftergame.tscn")
