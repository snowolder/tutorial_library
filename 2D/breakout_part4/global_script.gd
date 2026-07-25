extends Node

var currentLevel = 1
var currentScore = 0

var levelDict = {
	1: "res://level_scene.tscn",
	2: "res://level_2.tscn"
}

func get_current_level():
	return levelDict[currentLevel]

func reset_game():
	currentScore = 0
	currentLevel = 1
