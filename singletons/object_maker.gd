extends Node

enum BULLET_KEY { PLAYER, ENEMY }
enum SCENE_KEYS { EXPLOSION, PICKUP }

const BULLETS = {
	BULLET_KEY.PLAYER: preload("res://bullet/bullet_player/bullet_player.tscn"),
	BULLET_KEY.ENEMY: preload("res://bullet/bullet_enemy/bullet_enemy.tscn")
}

const SIMPLE_SCENES = {
	SCENE_KEYS.EXPLOSION: preload("res://enemy_explosion/enemy_explosion.tscn"),
	SCENE_KEYS.PICKUP: preload("res://fruit_pickup/fruit_pick_up.tscn")
}


func add_child_deferred(child_to_add) -> void:
	get_tree().root.add_child(child_to_add)
	
	
func call_add_child(child_to_add) -> void:
	call_deferred("add_child_deferred", child_to_add)	


func create_bullet(
	speed: float, 
	direction: Vector2, 
	start_pos: Vector2,
	life_span: float,
	key: BULLET_KEY
) -> void:
	var new_bullet = BULLETS[key].instantiate()
	new_bullet.setup(direction, life_span, speed)
	new_bullet.global_position = start_pos
	call_add_child(new_bullet)


func create_simple_scene(start_pos: Vector2, key: SCENE_KEYS) -> void:
	var new_sc = SIMPLE_SCENES[key].instantiate()
	new_sc.global_position = start_pos
	call_add_child(new_sc)
