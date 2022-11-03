extends Node2D

var laser_package: PackedScene = preload("res://scenes/Laser.tscn")


const MAX_SPEED = 300
const MAX_ACCELERATION = 10
const DAMPING_FACTOR = 0.97

@export
var speed = Vector2(1,1)
@export
var boosting: bool = false

signal ship_destroyed

func _ready():
	set_process(true)
	add_to_group("actors")
	add_to_group("ships")


@rpc(call_local)
func initialize(id: int, spawn_position: Vector2) -> void:
	name = str(id)
	$Label.text = State.players[id]
	set_multiplayer_authority(id)
	if not is_multiplayer_authority():
		$Input.queue_free()
	else:
		position = spawn_position


func _process(delta):
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


@rpc(any_peer, call_local)
func fire() -> void:
	var laser = laser_package.instantiate()
	laser.rotation = rotation
#	laser.update_speed()
	laser.position = position + laser.speed * 0.1
	add_sibling(laser, true)


func hurt() -> void:
	emit_signal("ship_destroyed")
	queue_free()
