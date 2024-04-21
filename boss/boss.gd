extends Node2D

const TRIGGER_CONDITION: String = "parameters/conditions/on_trigger"
const HIT_CONDITION: String = "parameters/conditions/on_hit"

@onready var animation_tree = $AnimationTree
@onready var visual = $Visual

@export var lives: int = 2
@export var points: int = 5

var _invincible: bool = false


func _ready():
	pass
	

func _process(delta):
	pass


func tween_hit() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(visual, "position", Vector2.ZERO, 1.0)


func reduce_lives() -> void:
	lives -= 1
	print("boss reduce lives: ", lives)
	if (lives <= 0):
		SignalManager.on_boss_killed.emit(points)
		print("boss dead")
		set_process(false)
		queue_free()


func set_invincible(val: bool) -> void:
	print("set_invincible: ", val)
	_invincible = val
	animation_tree[HIT_CONDITION] = val


func take_damage() -> void:
	if (_invincible == true): return
	
	set_invincible(true)
	tween_hit()
	reduce_lives()


func _on_trigger_area_entered(area):
	if (animation_tree[TRIGGER_CONDITION] == false):
		animation_tree[TRIGGER_CONDITION] = true


func _on_hit_box_area_entered(area):
	take_damage()
