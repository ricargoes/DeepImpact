extends Node

var level = 1
const MAX_LEVEL = 5
var win = false

# Default game server port. Can be any number between 1024 and 49151.
# Not on the list of registered or common poaaarts as of November 2020:
# https://en.wikipedia.org/wiki/List_of_TCP_and_UDP_port_numbers
const DEFAULT_PORT = 10567

# Max number of players.
const MAX_PEERS = 12

var peer = null

# Name for my player.
var player_name = "The Warrior"

# Names for remote players in id:name format.
@export
var players: Dictionary = {}

# Signals to let lobby GUI know what's going on.
signal player_added(player_id)
signal player_removed(player_id)
signal connection_failed()
signal connection_succeeded()
signal game_ended()
signal game_error(what)
signal game_started()

func set_connections(is_server: bool):
	if is_server:
		multiplayer.peer_disconnected.connect(_player_disconnected)
	else:
		multiplayer.connected_to_server.connect(_connected_ok)
		multiplayer.connection_failed.connect(_connected_fail)
		multiplayer.server_disconnected.connect(_server_disconnected)


# Callback from SceneTree.
func _player_disconnected(id):
	if has_node("/root/World"): # Game is in progress.
		if multiplayer.is_server():
			game_error.emit("Player " + players[id] + " disconnected")
			end_game()
	else: # Game is not in progress.
		# Unregister this player.
		unregister_player(id)


# Callback from SceneTree, only for clients (not server).
func _connected_ok():
	# We just connected to a server
	connection_succeeded.emit()
	rpc_id(1, "register_player", multiplayer.get_unique_id(), player_name)


# Callback from SceneTree, only for clients (not server).
func _server_disconnected():
	game_error.emit("Server disconnected")
	end_game()


# Callback from SceneTree, only for clients (not server).
func _connected_fail():
	multiplayer.set_network_peer(null) # Remove peer
	connection_failed.emit()


# Lobby management functions.
@rpc(any_peer)
func register_player(new_player_id: int, new_player_name: String):
	if multiplayer.is_server():
		players[new_player_id] = new_player_name
		player_added.emit(new_player_id)


func unregister_player(id):
	players.erase(id)
	player_removed.emit(id)


@rpc(call_local)
func load_world():
	Lobby.hide()


func host_game(new_player_name: String):
	player_name = new_player_name
	set_connections(true)
	peer = ENetMultiplayerPeer.new()
	peer.create_server(DEFAULT_PORT, MAX_PEERS)
	multiplayer.set_multiplayer_peer(peer)
	register_player(multiplayer.get_unique_id(), player_name)


func join_game(ip, new_player_name):
	player_name = new_player_name
	set_connections(false)
	peer = ENetMultiplayerPeer.new()
	peer.create_client(ip, DEFAULT_PORT)
	multiplayer.set_multiplayer_peer(peer)


func begin_game():
	assert(multiplayer.is_server())
	rpc("load_world")
	game_started.emit()


func end_game():
	if has_node("/root/World"): # Game is in progress.
		# End it
		get_node("/root/World").queue_free()

	game_ended.emit()
	players.clear()

