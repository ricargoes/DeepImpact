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
	
	if (get_node("Area2D").get_overlapping_areas().size() > 0):
		for thing in get_node("Area2D").get_overlapping_areas():
			if(thing.is_in_group("asteroids") and thing.has_method("hurt")):
				thing.hurt()
				queue_free()
	 
func new_speed(modulus, angle):
	return Vector2(modulus*cos(angle),-modulus*sin(angle))
	
func advance(delta):
	set_pos( get_pos() + speed*delta )
	
func update_speed():
	speed = new_speed(_SPEED_MODULUS, get_rot())