extends Node2D

@onready var floor_layer: TileMapLayer = $environment/FloorLayer

var draggingObject: Node2D

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("leftClick") and not draggingObject:
		_start_dragging()
	elif Input.is_action_just_pressed("leftClick") and draggingObject:
		_stop_dragging()

func _start_dragging():
	draggingObject = _get_object_on_mouse_position()
	
func _get_object_on_mouse_position():
	var mousePosition = get_global_mouse_position()
	
	var query = PhysicsPointQueryParameters2D.new()
	query.position = mousePosition
	
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_point(query)
	
	if result:
		return result[0].collider

func _stop_dragging():
	draggingObject = null

func _process(_delta: float) -> void:
	var tileMapPosition = _get_tile_map_layer_position()
	
	if draggingObject and tileMapPosition:
		draggingObject.global_position = tileMapPosition
	
func _get_tile_map_layer_position():
	var layerPosition = floor_layer.local_to_map(get_global_mouse_position())
	
	var atlasCoords = floor_layer.get_cell_atlas_coords(layerPosition)
	
	if atlasCoords == Vector2i(-1, -1):
		return
	
	return floor_layer.map_to_local(layerPosition)
