extends Node

var farm = {
	"ground": [],
	"soil": [],
	"plant": []
}

func _input(_event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_F1):
		_next_day()
		
func _next_day():
	save_farm()
	
	_check_and_reset_soil()
	_check_and_reset_plants()
	
	get_tree().reload_current_scene()

func _check_and_reset_soil():
	for soil in farm["soil"]:
		soil.hasWater = false

func _check_and_reset_plants():
	for plant in farm["plant"]:
		if plant.gotWater:
			plant.daysWatered += 1
			plant.gotWater = false

func save_farm():
	farm["ground"] = _get_group_save_data(get_tree().get_nodes_in_group("ground"))
	farm["soil"] = _get_group_save_data(get_tree().get_nodes_in_group("soil"))
	farm["plant"] = _get_group_save_data(get_tree().get_nodes_in_group("plant"))
	
func _get_group_save_data(group: Array) -> Array:
	var objectSaveData = []
	
	for object in group:
	
		objectSaveData.append(object.get_save_data())
		
	return objectSaveData

func get_data(group, id):
	for object in farm[group]:
		if object.id == id:
			return object
