extends Node3D

func _ready() -> void:
	_load_farm()

func _load_farm():
	# because of the grid delete and add new tiles
	await get_tree().process_frame
	
	var farmData = GameManager.farm

	for groundData in farmData["ground"]:
		var sceneGround = _get_scene_ground(groundData.id)
		
		for objectKeyWord in groundData["objectKeyWord"]:
			var objectName = objectKeyWord.split("_")[0]
			var objectId = objectKeyWord.split("_")[1]
			var isSoil = "Soil" in objectName
			
			if isSoil:
				var soilData = GameManager.get_data("soil", objectId)
				
				var soilNode = sceneGround.add_soil()
				soilNode.load_data(soilData)

func _get_scene_ground(id):
	for ground in get_tree().get_nodes_in_group("ground"):
		var groundName = ground.get_parent().name
		var groundId = str(ground.get_index())
		
		if groundName + "_" + groundId == id:
			return ground
