extends Node2D

@onready var player_camera = $PlayerCamera
@onready var player = $Player
@onready var hud = $CanvasLayer/HUD

func _ready():
	Engine.time_scale = 1
	var score = ScoreManager.get_score()
	hud.set_text_score(score)
	
	
func _process(_delta):
	player_camera.position = player.position

	#if (Input.is_action_just_pressed("left") == true):
		#GameManager.load_main_scene()
		#
	#if (Input.is_action_just_pressed("right") == true):
		#GameManager.load_next_level_scene()


