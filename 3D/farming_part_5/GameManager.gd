extends Node

var farm = {
	"ground": [],
	"soil": []
}

func _input(_event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_F1):
		_next_day()
		
func _next_day():
	save_farm()
	get_tree().reload_current_scene()

func save_farm():
	farm["ground"] = _get_group_save_data(get_tree().get_nodes_in_group("ground"))
	farm["soil"] = _get_group_save_data(get_tree().get_nodes_in_group("soil"))
	
func _get_group_save_data(group: Array) -> Array:
	var objectSaveData = []
	
	for object in group:
		objectSaveData.append(object.get_save_data())
		
	return objectSaveData

func get_data(group, id):
	for object in farm[group]:
		if object.id == id:
			return object
