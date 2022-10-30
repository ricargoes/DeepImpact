extends Node

const _DELTA_ROT = 1.0/60*2*PI

func _ready():
	set_process(true)


func _process(_delta):
	var ship: Node2D = get_parent()
	if(Input.is_action_pressed("up")):
		ship.boost()
	else:
		ship.boosting = false
	if(Input.is_action_pressed("left")):
		ship.rotate( -_DELTA_ROT )
	elif(Input.is_action_pressed("right")):
		ship.rotate( _DELTA_ROT )
	if(Input.is_action_pressed("down")):
		ship.damp_speed()


func _input(event):
	if(event.is_action_pressed("fire")):
		get_parent().rpc_id(1, "fire")
	
	if(Input.is_action_pressed("exit")):
		get_tree().quit()
