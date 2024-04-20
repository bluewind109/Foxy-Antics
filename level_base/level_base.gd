extends Node2D

@onready var player_camera = $PlayerCamera
@onready var player = $Player

func _ready():
	pass
	
func _physics_process(delta):
	player_camera.position = player.position
