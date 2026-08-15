extends Node2D

var draggingObject: Node2D

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("leftClick"):
		_drag_object_on_mouse_position()
	elif Input.is_action_just_released("leftClick"):
		_release_drag()

func _drag_object_on_mouse_position():
	var object = _get_object_on_mouse_position()
	
	if not object:
		return
	
	draggingObject = object
	object.set_physics_process(false)

func _get_object_on_mouse_position():
	var mousePosition = get_global_mouse_position()
	
	var query = PhysicsPointQueryParameters2D.new()
	query.position = mousePosition
	query.collide_with_areas = true
	
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_point(query)
	
	if result:
		return result[0].collider

func _release_drag():
	if not draggingObject:
		return
	
	draggingObject.set_physics_process(true)
	draggingObject = null

func _process(_delta: float) -> void:
	if not draggingObject: 
		return
		
	draggingObject.global_position = get_global_mouse_position()
