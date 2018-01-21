extends Node2D

export var speed = Vector2(1,1)

const _ACCELERATION = 10

const _MAX_SPEED = 300
const _DELTA_SPEED = 0.97
const _DELTA_ROT = 1.0/60*2*PI

const _UI_UP = "ui_up"
const _UI_DOWN = "ui_down"  
const _UI_RIGHT = "ui_right"
const _UI_LEFT = "ui_left"

func _ready():
	set_process(true)
	set_process_input(true)

func _process(delta):
	set_pos( get_pos() + speed*delta )
	
	if(Input.is_action_pressed(_UI_UP)):
		speed = speed + new_speed(_ACCELERATION, get_rot())
	if(Input.is_action_pressed(_UI_LEFT)):
		set_rot( get_rot()+_DELTA_ROT )
	elif(Input.is_action_pressed(_UI_RIGHT)):
		set_rot( get_rot()-_DELTA_ROT )
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

func new_speed(modulus,angle):	
	return Vector2(modulus*cos(angle),-modulus*sin(angle))