extends Node2D

var laser_package: PackedScene = preload("res://scenes/Laser.tscn")

var boosting: bool = false
const MAX_SPEED = 300
const MAX_ACCELERATION = 10
const DAMPING_FACTOR = 0.97

var synced_position := Vector2()

@export
var speed = Vector2(1,1)

func _ready():
	set_process(true)
	add_to_group("actors")
	add_to_group("ships")


func _process(delta):

	if multiplayer.multiplayer_peer == null or is_multiplayer_authority():
		# The server updates the position that will be notified to the clients.
		synced_position = position
	else:
		# The client simply updates the position to the last known one.
		position = synced_position
	position += speed*delta
	
	if boosting:
		$Booster.show()
	else:
		$Booster.hide()


func boost() -> void:
	boosting = true
	speed.x = clampf(speed.x + MAX_ACCELERATION*cos(rotation), -MAX_SPEED, MAX_SPEED)
	speed.y = clampf(speed.y + MAX_ACCELERATION*sin(rotation), -MAX_SPEED, MAX_SPEED)

func damp_speed():
	speed *= DAMPING_FACTOR

func fire() -> void:
	var laser = laser_package.instantiate()
	laser.rotation = rotation
	laser.update_speed()
	laser.position = position + laser.speed * 0.1
	add_sibling(laser, true)


func hurt() -> void:
	State.win = false
	get_tree().change_scene_to_file("res://scenes/Aftergame.tscn")


func set_player_name(value):
	$Label.text = value
