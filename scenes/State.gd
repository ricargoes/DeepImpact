extends Node

var level = 1
const MAX_LEVEL = 5
var score = 0
var win = false
var active_scene

func add_score_point():
	score+=1

func change_scene(scene_path):
	var scene_instance = load(scene_path).instance()
	if active_scene != null:
		active_scene.queue_free()
	active_scene = scene_instance
	get_tree().get_root().add_child(scene_instance)
	