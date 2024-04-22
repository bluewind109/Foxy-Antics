extends Node

const HS_FILE: String = "user://SCORES.dat"
const HS_KEY: String = "highscore"

var _score: int = 0
var _highscore: int = 0

func _ready():
	load_highscore()
	SignalManager.on_boss_killed.connect(on_boss_killed)
	SignalManager.on_pickup_hit.connect(on_pickup_hit)
	SignalManager.on_enemy_hit.connect(on_enemy_hit)
	
	SignalManager.on_level_complete.connect(on_level_complete)
	SignalManager.on_game_over.connect(on_game_over)


func update_score(points: int) -> void:
	_score += points
	SignalManager.on_score_updated.emit(_score)
	if (_highscore < _score):
		_highscore = _score
	print("update score: ", _score)
		
		
func get_score() -> int:
	return _score
	
	
func get_highscore() -> int:
	return _highscore


func reset_score() -> void:
	_score = 0


func save_highscore() -> void:
	var file = FileAccess.open(HS_FILE, FileAccess.WRITE)
	
	var data = {
		HS_KEY: _highscore
	}
	
	file.store_string(JSON.stringify(data))
	print("saved _highscore: ", data)


func load_highscore() -> void:
	if (FileAccess.file_exists(HS_FILE) == false):
		return
		
	var file = FileAccess.open(HS_FILE, FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())

	print("data: ", data)
	if (HS_KEY in data):
		_highscore = data[HS_KEY]
		print("loaded _highscore: ", _highscore)
	
	
func on_boss_killed(points: int) -> void:
	update_score(points)
	
	
func on_pickup_hit(points: int) -> void:
	update_score(points)
	
	
func on_enemy_hit(points: int, _v: Vector2) -> void:
	update_score(points)
	

func on_level_complete() -> void:
	save_highscore()
	
	
func on_game_over() -> void:
	save_highscore()




