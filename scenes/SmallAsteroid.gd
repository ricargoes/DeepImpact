extends Area2D

const MAX_SPEED = 400
const MAX_ANGULAR_SPEED = 2*PI
var speed
var angular_speed

func _ready():
	add_to_group("actors")
	add_to_group("asteroids")
	randomize()
	var angle = rand_range(0, 2*PI)
	var speed_module = rand_range(0, MAX_SPEED)
	speed = Vector2(speed_module*cos(angle), speed_module*sin(angle))
	angular_speed = rand_range(-MAX_ANGULAR_SPEED, MAX_ANGULAR_SPEED)
	set_process(true)
	#set_scale(Vector2(0.5,0.5))

func _process(delta):
	set_position(get_position()+delta*speed)
	set_rotation(get_rotation()+delta*angular_speed)
	
	if (get_overlapping_areas().size() > 0):
		for area in get_overlapping_areas():
			var thing = area.get_parent()
			if(thing.is_in_group("ships") and thing.has_method("hurt")):
				thing.hurt()
				

func hurt():
	State.add_score_point()
	queue_free()