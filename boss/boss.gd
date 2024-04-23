extends Node2D

const TRIGGER_CONDITION: String = "parameters/conditions/on_trigger"
const HIT_CONDITION: String = "parameters/conditions/on_hit"

@onready var animation_tree = $AnimationTree
@onready var visual = $Visual
@onready var hit_box = $Visual/HitBox

@export var lives: int = 2
@export var points: int = 5

var _invincible: bool = false
var _has_arrived: bool = false


func _ready():
	hit_box.monitoring = false


func tween_hit() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(visual, "position", Vector2.ZERO, 1.0)


func reduce_lives() -> void:
	lives -= 1
	if (lives <= 0):
		SignalManager.on_boss_killed.emit(points)
		set_process(false)
		queue_free()


func set_invincible(val: bool) -> void:
	_invincible = val
	animation_tree[HIT_CONDITION] = val


func take_damage() -> void:
	if (_has_arrived == false): return
	if (_invincible == true): return
	
	set_invincible(true)
	tween_hit()
	reduce_lives()


func get_has_arrived() -> bool:
	return _has_arrived


func on_arrive_finished() -> void:
	hit_box.set_deferred("monitoring", true)
	_has_arrived = true


func _on_trigger_area_entered(_area):
	if (animation_tree[TRIGGER_CONDITION] == false):
		animation_tree[TRIGGER_CONDITION] = true


func _on_hit_box_area_entered(_area):
	take_damage()
