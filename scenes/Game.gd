extends Node

var ship_scene: PackedScene = load("res://scenes/Ship.tscn")

func _ready():
	State.player_added.connect(spawn_ship)
	State.game_started.connect(start)
	get_tree().paused = true


@rpc(any_peer, call_local)
func start():
	spawn_asteroids()
	get_tree().paused = false


func spawn_ship(id):
	if(!multiplayer.is_server()):
		return

	var spawning_point: Marker2D = $SpawningPoints.get_children().front()
	var ship = ship_scene.instantiate()
	ship.synced_position = spawning_point.position
	ship.position = spawning_point.position
	ship.name = str(id)
	ship.set_player_name(State.players[id])
	$Ships.add_child(ship, true)
	spawning_point.queue_free()


func spawn_asteroids():
	if(!multiplayer.is_server()):
		return
#	var n_asteroids = 2*State.level
	var asteroid_scene = load("res://scenes/BigAsteroid.tscn")
	for i in range(0,1):
		var asteroid = asteroid_scene.instantiate()
		$Asteroids.add_child(asteroid, true)


func _process(_delta):
	var actors = get_tree().get_nodes_in_group("actors")
	for actor in actors:
		var width = get_viewport().get_visible_rect().size.x
		var height = get_viewport().get_visible_rect().size.y
		actor.position = Vector2(fposmod(actor.position.x, width), fposmod(actor.position.y, height))
	
	check_victory()


func check_victory():
	if(!multiplayer.is_server()):
		return
	if(get_tree().get_nodes_in_group("asteroids").size()==0):
		victory()


func victory():
	State.win = true
	get_tree().change_scene_to_file("res://scenes/Aftergame.tscn")
