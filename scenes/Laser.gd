extends Node2D

const _SPEED_MODULUS = 800

var speed = Vector2(0,0)
var countdown = 2.0

func _ready():
	set_process(true)
	add_to_group("actors")

func _process(delta):
	advance(delta)
	countdown -= delta
	
	if(countdown <= 0):
		queue_free()
	 
func new_speed(modulus, angle):
	return Vector2(modulus*cos(angle),-modulus*sin(angle))
	
func advance(delta):
	set_pos( get_pos() + speed*delta )
	
func update_speed():
	speed = new_speed(_SPEED_MODULUS, get_rot())