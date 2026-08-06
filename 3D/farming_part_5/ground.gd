extends StaticBody3D
class_name Ground

@onready var selection_mesh: MeshInstance3D = %selectionMesh
@onready var objects: Node3D = $objects

const SOIL = preload("uid://d3s2lityv6yyh")
const PLANT_SCENE = preload("uid://c7nx1w6gsguer")

var hasSoil = false

func _ready() -> void:
	add_to_group("ground")
	selection_mesh.hide()

func set_selection(boolean: bool):
	selection_mesh.visible = boolean

func tool_interaction(toolType: ITEM_BAR_ITEM.ITEM_TYPES):
	var canSoil = not hasSoil and toolType == ITEM_BAR_ITEM.ITEM_TYPES.HOE
	
	if canSoil:
		add_soil()
	else:
		for object in objects.get_children():
			if object.has_method("tool_interaction"):
				object.tool_interaction(toolType)

func add_soil():
	hasSoil = true
	
	var soilNode = SOIL.instantiate()
	objects.add_child(soilNode)
	soilNode.position.y = 0.05
	selection_mesh.position.y = 0.1
	
	return soilNode

func item_interaction(item: ITEM_BAR_ITEM):
	var isSeed = item.itemType == ITEM_BAR_ITEM.ITEM_TYPES.SEED
	if isSeed and hasSoil and objects.get_child_count() == 1:
		add_plant(item.plantResource)
		return 1
		
	return 0

func add_plant(plantResource: PLANT_RESOURCE):
	var plantNode = PLANT_SCENE.instantiate()
	plantNode.plantResource = plantResource
	objects.add_child(plantNode)

	return plantNode
	
func get_save_data() -> Dictionary:
	var objectNames = []
	
	for child in objects.get_children():
		var objectName = child.name + "_" + str(child.get_instance_id())
		objectNames.append(objectName)
	
	return {
		"id": get_parent().name + "_" + str(get_index()),
		"hasSoil": hasSoil,
		"objectKeyWord": objectNames
	}




	
