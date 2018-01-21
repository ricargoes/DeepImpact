extends Node2D

export var speed = Vector2(0,0)

const _SPEED_MODULUS = 200

const _UI_UP = "ui_up" 
const _UI_DOWN = "ui_down"
const _UI_RIGHT = "ui_right"
const _UI_LEFT = "ui_left"

func _ready():
	set_process(true)
	set_process_input(true)

func _process(delta):
	set_pos( get_pos() + speed*delta )

func _input(event):
	
	if(event.is_action_pressed(_UI_UP)):
		print("lalala")
		speed =  Vector2(0,-_SPEED_MODULUS)
	if(event.is_action_released(_UI_UP)):
		speed =  Vector2(0,0)
	if(event.is_action_pressed(_UI_DOWN)):
		speed =  Vector2(0,_SPEED_MODULUS)
	if(event.is_action_released(_UI_DOWN)):
		speed =  Vector2(0,0)