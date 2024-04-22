extends CanvasLayer

@onready var label_highscore = $VB/LabelHighscore

# Called when the node enters the scene tree for the first time.
func _ready():
	Engine.time_scale = 1
	label_highscore.text = str(ScoreManager.get_highscore())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_pressed("jump") == true):
		GameManager.start_game()
