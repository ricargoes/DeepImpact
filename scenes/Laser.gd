extends Node2D

const _SPEED_MODULUS = 800

@export
var speed = Vector2(0,0)


func _ready():
	set_process(true)
	add_to_group("actors")
	update_speed()


func _process(delta):
	position += speed*delta
	
	for thing in $Area2D.get_overlapping_areas():
		if(thing.is_in_group("asteroids") and thing.has_method("hurt")):
			thing.hurt()
			queue_free()


func update_speed():
	speed = Vector2(_SPEED_MODULUS*cos(rotation), _SPEED_MODULUS*sin(rotation))


func vanish():
	queue_free()
