extends CharacterBody3D

@onready var head_wool: MeshInstance3D = $sheep/HeadWool
@onready var wool: MeshInstance3D = $sheep/wool

var toolUsable = true

func tool_interaction(tool: ITEM_BAR_ITEM.ITEM_TYPES):
	if not toolUsable or tool != ITEM_BAR_ITEM.ITEM_TYPES.SHEARER:
		return
		
	toolUsable = false
	head_wool.hide()
	wool.hide()
