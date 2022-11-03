extends Control

func _ready():
	# Called every time the node is added to the scene.
	State.connection_failed.connect(_on_connection_failed)
	State.connection_succeeded.connect(_on_connection_success)
	State.game_ended.connect(_on_game_ended)
	State.game_error.connect(_on_game_error)
	# Set the player name according to the system username. Fallback to the path.
	if OS.has_environment("USERNAME"):
		$Connect/Name.text = OS.get_environment("USERNAME")
	else:
		var desktop_path = OS.get_system_dir(0).replace("\\", "/").split("/")
		$Connect/Name.text = desktop_path[desktop_path.size() - 2]


func _on_host_pressed():
	if $Connect/Name.text == "":
		$Connect/ErrorLabel.text = "Invalid name!"
		return

	$Connect.hide()
	$Players.show()
	$Players/ListRefresh.start()
	$Connect/ErrorLabel.text = ""

	var player_name = $Connect/Name.text
	State.host_game(player_name)


func _on_join_pressed():
	if $Connect/Name.text == "":
		$Connect/ErrorLabel.text = "Invalid name!"
		return

	var ip = $Connect/IPAddress.text
	if not ip.is_valid_ip_address():
		$Connect/ErrorLabel.text = "Invalid IP address!"
		return

	$Connect/ErrorLabel.text = ""
	$Connect/Host.disabled = true
	$Connect/Join.disabled = true

	var player_name = $Connect/Name.text
	State.join_game(ip, player_name)


func _on_connection_success():
	$Connect.hide()
	$Players.show()
	$Players/ListRefresh.start()


func _on_connection_failed():
	$Connect/Host.disabled = false
	$Connect/Join.disabled = false
	$Connect/ErrorLabel.set_text("Connection failed.")


func _on_game_ended():
	show()
	$Connect.show()
	$Players.hide()
	$Connect/Host.disabled = false
	$Connect/Join.disabled = false


func _on_game_error(errtxt):
	$ErrorDialog.dialog_text = errtxt
	$ErrorDialog.popup_centered()
	$Connect/Host.disabled = false
	$Connect/Join.disabled = false


func refresh_lobby():
	var players_id = State.players.keys()
	players_id.sort()
	$Players/List.clear()
	for p_id in players_id:
		var player_name = State.players[p_id]
		if p_id == multiplayer.get_unique_id():
			player_name += " (You)"
		$Players/List.add_item(player_name)

	$Players/Start.disabled = not multiplayer.is_server()


func _on_start_pressed():
	$Players/ListRefresh.stop()
	State.begin_game()


func _on_find_public_ip_pressed():
	OS.shell_open("https://icanhazip.com/")
