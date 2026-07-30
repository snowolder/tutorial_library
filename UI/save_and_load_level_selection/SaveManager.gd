extends Node

var save_path = "user://savegame.save"

# Simplified form of stored level information
var levelList = [
	{"unlocked": true, "done": true},
	{"unlocked": true, "done": true},
	{"unlocked": true, "done": true},
	{"unlocked": true, "done": true},
	{"unlocked": true, "done": true},
	{"unlocked": true, "done": false},
	{"unlocked": false, "done": false},
	{"unlocked": false, "done": false},
	{"unlocked": false, "done": false},
	{"unlocked": false, "done": false},
	{"unlocked": false, "done": false},
	{"unlocked": false, "done": false},
	{"unlocked": false, "done": false},
	{"unlocked": false, "done": false},
	{"unlocked": false, "done": false},
	{"unlocked": false, "done": false},
	{"unlocked": false, "done": false},
	{"unlocked": false, "done": false},
	{"unlocked": false, "done": false},
	{"unlocked": false, "done": false},
	{"unlocked": false, "done": false},
	{"unlocked": false, "done": false},
	{"unlocked": false, "done": false},
	{"unlocked": false, "done": false},
	{"unlocked": false, "done": false},
	{"unlocked": false, "done": false},
	{"unlocked": false, "done": false},
	{"unlocked": false, "done": false},
	{"unlocked": false, "done": false},
	{"unlocked": false, "done": false},
	{"unlocked": false, "done": false},
	{"unlocked": false, "done": false},
	{"unlocked": false, "done": false},
	{"unlocked": false, "done": false},
	{"unlocked": false, "done": false},
	{"unlocked": false, "done": false},
	{"unlocked": false, "done": false},
	{"unlocked": false, "done": false},
]

func save_game():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	var jsonString = JSON.stringify(levelList)
	file.store_line(jsonString)

func load_game():
	var file = FileAccess.open(save_path, FileAccess.READ)
	
	if not FileAccess.file_exists(save_path):
		return
	
	var data = JSON.parse_string(file.get_line())
	levelList = data
