extends CharacterBody2D

class_name EnemyBase

enum FACING { LEFT = -1, RIGHT = 1 }

const OFF_SCREEN_KILL_ME: float = 1000.0

@export var default_facing: FACING = FACING.LEFT
@export var points: int = 1
@export var speed: float = 30.0

var _gravity: float = 800.0
var _facing: FACING = default_facing
var _player_ref: Player
var _dying: bool = false

func _ready():
	_player_ref = get_tree().get_nodes_in_group(GameManager.GROUP_PLAYER)[0]


func _physics_process(_delta):
	fallen_off()


func fallen_off() -> void:
	if (global_position.y > OFF_SCREEN_KILL_ME):
		queue_free()


func die() -> void:
	if (_dying == true): return
	
	_dying = true
	SignalManager.on_enemy_hit.emit(points, global_position)
	ObjectMaker.create_simple_scene(global_position, ObjectMaker.SCENE_KEYS.EXPLOSION)
	ObjectMaker.create_simple_scene(global_position, ObjectMaker.SCENE_KEYS.PICKUP)
	set_physics_process(false)
	hide()
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_entered():
	pass # Replace with function body.


func _on_visible_on_screen_notifier_2d_screen_exited():
	pass # Replace with function body.


func _on_hit_box_area_entered(_area):
	die()
