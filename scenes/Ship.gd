extends Node2D

export var speed = Vector2(1,1)

const _ACCELERATION = 10

const _MAX_SPEED = 50

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
	if(Input.is_action_pressed(_UI_DOWN)):
		speed = speed - new_speed(_ACCELERATION, get_rot())
	
	if(speed.x > _MAX_SPEED):
		speed = Vector2(_MAX_SPEED, speed.y)
	if(speed.y > _MAX_SPEED):
		speed = Vector2(speed.x, _MAX_SPEED)
	if(speed.x < 0):
		speed = Vector2(0,speed.y)
	elif(speed.y < 0):
		speed = Vector2(speed.x,0)

func new_speed(modulus,angle):	
	return Vector2(modulus*cos(angle),-modulus*sin(angle))