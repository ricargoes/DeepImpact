extends Area2D

const MAX_SPEED = 400
var speed

func _ready():
	add_to_group("asteroids")
	randomize()
	var angle = rand_range(0, 2*PI)
	var speed_module = rand_range(0, MAX_SPEED)
	speed = Vector2(speed_module*cos(angle), speed_module*sin(angle))
	set_process(true)
	set_scale(Vector2(0.5,0.5))

func _process(delta):
	self.set_pos(self.get_pos()+delta*speed)
