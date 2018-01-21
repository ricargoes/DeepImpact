extends Area2D

const MAX_SPEED = 400
const MAX_ANGULAR_SPEED = 2*PI
var speed
var angular_speed

func _ready():
	add_to_group("asteroids")
	randomize()
	var angle = rand_range(0, 2*PI)
	var speed_module = rand_range(0, MAX_SPEED)
	speed = Vector2(speed_module*cos(angle), speed_module*sin(angle))
	angular_speed = rand_range(-MAX_ANGULAR_SPEED, MAX_ANGULAR_SPEED)
	set_process(true)
	#set_scale(Vector2(0.5,0.5))

func _process(delta):
	self.set_pos(self.get_pos()+delta*speed)
	self.set_rot(self.get_rot()+delta*angular_speed)

func hurt():
	queue_free()