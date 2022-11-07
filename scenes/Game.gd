extends Node

var ship_scene: PackedScene = load("res://scenes/Ship.tscn")

func _ready():
	State.game_started.connect(start)
	Aftergame.game_reloaded.connect(start)
	get_tree().paused = true


func start():
	clear()
	spawn_asteroids()
	spawn_ships()
	State.rpc("hide_lobby")
	rpc("unpause_game")


@rpc(call_local)
func unpause_game() -> void:
	get_tree().paused = false


func spawn_ships() -> void:
	var spawning_points = $SpawningPoints.get_children()
	var player_ids = State.players.keys()
	player_ids.sort()
	for i in player_ids.size():
		spawn_ship(player_ids[i], spawning_points[i].position)


func spawn_ship(id, spawn_position):
	var ship = ship_scene.instantiate()
	ship.connect("ship_destroyed", defeat)
	$Ships.add_child(ship, true)
	ship.rpc("initialize", id, spawn_position)


func spawn_asteroids():
	if(!multiplayer.is_server()):
		return
	var n_asteroids = 2*State.level
	var asteroid_scene = load("res://scenes/BigAsteroid.tscn")
	for i in range(0, n_asteroids):
		var asteroid = asteroid_scene.instantiate()
		asteroid.position = Vector2(300,0)
		$Asteroids.add_child(asteroid, true)


func clear() -> void:
	clear_children($Ships)
	clear_children($Asteroids)


func clear_children(node: Node) -> void:
	for child in node.get_children():
		child.queue_free()


func _process(_delta):
	
	var actors = get_tree().get_nodes_in_group("actors")
	for actor in actors:
		if actor.is_multiplayer_authority():
			var width = get_viewport().get_visible_rect().size.x
			var height = get_viewport().get_visible_rect().size.y
			actor.position = Vector2(fposmod(actor.position.x, width), fposmod(actor.position.y, height))
	
	if multiplayer.is_server():
		check_victory()


func check_victory():
	if(!multiplayer.is_server()):
		return
	if(get_tree().get_nodes_in_group("asteroids").size()==0):
		victory()


func victory() -> void:
	Aftergame.rpc("launch", true, State.level)
	State.level += 1


func defeat() -> void:
	Aftergame.rpc("launch", false, State.level)
	State.level = 1
