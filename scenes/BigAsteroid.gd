extends Area2D

const MAX_SPEED: float = 400
const MAX_ANGULAR_SPEED: float = 2*PI
var asteroid_division: int
var speed: Vector2
var angular_speed: float

func _ready():
	add_to_group("actors")
	add_to_group("asteroids")
	asteroid_division = State.level*2
	randomize()
	var angle = randf_range(0, 2*PI)
	var speed_module = randf_range(0, MAX_SPEED)
	speed = Vector2(speed_module*cos(angle), speed_module*sin(angle))
	angular_speed = randf_range(-MAX_ANGULAR_SPEED, MAX_ANGULAR_SPEED)
	set_process(true)

func _process(delta):
	position += delta*speed
	rotation += delta*angular_speed
	
	if (get_overlapping_areas().size() > 0):
		for area in get_overlapping_areas():
			var thing = area.get_parent()
			if(thing.is_in_group("ships") and thing.has_method("hurt")):
				thing.hurt()
	

func hurt():
	var small_asteroid_maker = load("res://scenes/SmallAsteroid.tscn")
	for small_asteroid in range(0,asteroid_division):
		var sa = small_asteroid_maker.instantiate()
		get_parent().add_child(sa, true)
		sa.set_position(get_position())
	queue_free()
