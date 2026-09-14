extends Node3D

@onready var model: Node3D = $model

var plantResource: PLANT_RESOURCE

var daysWatered = 0
var gotWater = false

func _ready() -> void:
	add_to_group("plant")
	
	_refresh_model()
	
func _refresh_model():
	if model.get_child_count() == 1:
		model.get_child(0).queue_free()
	
	var currentStage = _get_current_stage()

	var plantScene = plantResource.stageScenes[currentStage].instantiate()
	model.add_child(plantScene)

func _get_current_stage():
	var calculateDays = 0
	var stage = 0

	for days in plantResource.daysPerStage:
		calculateDays += days

		if daysWatered < calculateDays:
			break
		
		stage += 1
	
	return stage

func tool_interaction(toolType: ITEM_BAR_ITEM.ITEM_TYPES):
	if toolType == ITEM_BAR_ITEM.ITEM_TYPES.WATERING_CAN:
		gotWater = true

func get_save_data():
	return {
		"id": str(get_instance_id()),
		"plantResourcePath": plantResource.get_path(),
		"daysWatered": daysWatered,
		"gotWater": gotWater,
	}

func load_data(data):
	if not data: return

	daysWatered = data.daysWatered
	gotWater = data.gotWater
	
	_refresh_model()
