extends Control

@onready var score_label: Label = %scoreLabel
@onready var ball_label: Label = %ballLabel
@onready var game_over: Control = $GameOver
@onready var game_clear: Control = $GameClear

func _ready() -> void:
	game_over.hide()
	game_clear.hide()
	
	process_mode = Node.PROCESS_MODE_ALWAYS

func start_game(ballsLeft):
	score_label.text = str(GlobalScript.currentScore)
	ball_label.text = str(ballsLeft)

func set_game_over():
	game_over.show()

func set_level_clear():
	get_tree().paused = true
	game_clear.show()

func update_score():
	score_label.text = str(GlobalScript.currentScore)

func update_balls(newValue):
	ball_label.text = str(newValue)

func _on_game_over_button_pressed() -> void:
	GlobalScript.reset_game()
	
	var levelPath = GlobalScript.get_current_level()
	get_tree().change_scene_to_file(levelPath)

func _on_game_clear_button_pressed() -> void:
	get_tree().paused = false
	GlobalScript.currentLevel += 1
	
	var levelPath = GlobalScript.get_current_level()
	get_tree().change_scene_to_file(levelPath)
