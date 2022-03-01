extends Node2D

@export
var speed = Vector2(1,1)

const TICK = 1.0/60

const _ACCELERATION = 10

const _MAX_SPEED = 300
const _DELTA_SPEED = 0.97
const _DELTA_ROT = 1.0/60*2*PI

const _UI_UP = "ui_up"
const _UI_DOWN = "ui_down"  
const _UI_RIGHT = "ui_right"
const _UI_LEFT = "ui_left"
const _UI_FIRE = "ui_fire"
const _EXIT = "exit"

func _ready():
	set_process(true)
	set_process_input(true)
	add_to_group("actors")
	add_to_group("ships")

func _process(delta):
	set_position( get_position() + speed*delta )
	
	if(Input.is_action_pressed(_UI_UP)):
		speed = speed + new_speed(_ACCELERATION, get_rotation())
	if(Input.is_action_pressed(_UI_LEFT)):
		set_rotation( get_rotation()-_DELTA_ROT )
	elif(Input.is_action_pressed(_UI_RIGHT)):
		set_rotation( get_rotation()+_DELTA_ROT )
	if(Input.is_action_pressed(_UI_DOWN)):
		speed = _DELTA_SPEED*speed
	
	if(speed.x > _MAX_SPEED):
		speed = Vector2(_MAX_SPEED, speed.y)
	if(speed.y > _MAX_SPEED):
		speed = Vector2(speed.x, _MAX_SPEED)
	if(speed.x < -_MAX_SPEED):
		speed = Vector2(-_MAX_SPEED,speed.y)
	if(speed.y < -_MAX_SPEED):
		speed = Vector2(speed.x,-_MAX_SPEED)

func _input(event):
	if(event.is_action_pressed(_UI_FIRE)):
		var laser_package = load("res://scenes/Laser.tscn")
		var laser = laser_package.instantiate()
		get_parent().add_child(laser)
		laser.set_position(get_position()+speed*TICK)
		laser.set_rotation(get_rotation())
		laser.update_speed()
		laser.advance(2*TICK)

	if(Input.is_action_pressed(_EXIT)):
		get_tree().quit()

func new_speed(modulus,angle):	
	return Vector2(modulus*cos(angle),modulus*sin(angle))
	
func hurt():
	State.win = false
	get_tree().change_scene("res://scenes/Aftergame.tscn")
