extends Sprite

func _ready():
	set_process(true)
	set_process_input(true)
	set_hidden(true)

func _input(event):
	if(event.is_action_pressed(get_parent()._UI_UP)):
		set_hidden(false)
	elif(event.is_action_released(get_parent()._UI_UP)):
		set_hidden(true)