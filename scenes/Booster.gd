extends Sprite

func _ready():
	set_process(true)
	set_process_input(true)
	hide()

func _input(event):
	if(event.is_action_pressed(get_parent()._UI_UP)):
		show()
	elif(event.is_action_released(get_parent()._UI_UP)):
		hide()