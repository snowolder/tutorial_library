extends Node3D

@onready var model: Node3D = $model

var plantResource: PLANT_RESOURCE

func _ready() -> void:
	var plantScene = plantResource.stageScenes[0].instantiate()
	model.add_child(plantScene)
