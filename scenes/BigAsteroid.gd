extends Area2D

const MAX_SPEED = 400
const MAX_ANGULAR_SPEED = 2*PI
var speed
var angular_speed
var count_down = 1
const MAX_ASTEROID_DIVISION = 2

func _ready():
	add_to_group("actors")
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
	count_down-=delta
	

func hurt():
	state.add_score_point()
	var small_asteroid_maker = load("res://scenes/SmallAsteroid.tscn")
	for small_asteroid in range(0,MAX_ASTEROID_DIVISION):
		var sa1 = small_asteroid_maker.instance()
		self.get_parent().add_child(sa1)
		sa1.set_pos(self.get_pos())
	queue_free()