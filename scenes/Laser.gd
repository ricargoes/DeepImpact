extends Node2D

const _SPEED_MODULUS = 800

var speed = Vector2(0,0)

func _ready():
	set_process(true)

func _process(delta):
	advance(delta)
	 
func new_speed(modulus, angle):
	return Vector2(modulus*cos(angle),-modulus*sin(angle))
	
func advance(delta):
	set_pos( get_pos() + speed*delta )
	
func update_speed():
	speed = new_speed(_SPEED_MODULUS, get_rot())