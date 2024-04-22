extends Node

const GROUP_PLAYER: String = "player"
const TOTAL_LEVELS: int = 3
const MAIN_SCENE: PackedScene = preload("res://main/main.tscn")

var _current_level: int = 0
var _level_scenes = {}

func _ready():
	init_level_scenes()
	
	
func init_level_scenes() -> void:
	for ln in range(TOTAL_LEVELS):
		_level_scenes[ln] = load("res://level_base/levels/level_%s.tscn" % ln)
		
		
func load_main_scene() -> void:
	_current_level = 0
	get_tree().change_scene_to_packed(MAIN_SCENE)


func load_next_level_scene() -> void:
	set_next_level()
	get_tree().change_scene_to_packed(_level_scenes[_current_level])


func set_next_level() -> void:
	_current_level += 1
	if (_current_level > TOTAL_LEVELS):
		_current_level = 1




