extends CharacterBody3D

@onready var model: Node3D = $model
@onready var animation_player: AnimationPlayer = $model/AnimationPlayer
@onready var third_person_camera: Node3D = $thirdPersonCamera
@onready var ray_cast_3d: RayCast3D = $model/RayCast3D
@onready var object_position_marker: Marker3D = %objectPositionMarker

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var onAction = false

func _input(_event: InputEvent) -> void:
	if onAction:
		return
	
	if Input.is_action_just_pressed("interaction"):
		var isMovableObject = ray_cast_3d.is_colliding() and ray_cast_3d.get_collider() is MovableObject
		var hasObject = object_position_marker.get_child_count() == 1
		
		if isMovableObject and not hasObject:
			_pick_up(ray_cast_3d.get_collider())
		elif hasObject and not ray_cast_3d.is_colliding():
			var currentObject = object_position_marker.get_child(0)
			_put_down(currentObject)

func _pick_up(object):
	onAction = true
	
	animation_player.play("PickUp")
	await animation_player.animation_finished
	
	object.reparent(object_position_marker)
	object.global_position = object_position_marker.global_position
	object.disable_collision(true)

	onAction = false
	
func _put_down(object):
	onAction = true
		
	object.reparent(get_tree().current_scene)
	var targetPosition = global_position + model.transform.basis * Vector3(0,0,1.5)
	object.global_position = targetPosition
	object.disable_collision(false)
	
	animation_player.play_backwards("PickUp")
	await animation_player.animation_finished
	
	onAction = false

func _physics_process(delta: float) -> void:
	if onAction:
		return
		
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	# Handle jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("movement_left", "movement_right", "movement_up", "movement_down")
	var direction = (third_person_camera.global_transform.basis  * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	direction.y = 0

	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	_set_animation(direction)

	move_and_slide()

func _set_animation(direction):
	if direction:
		var targetAngle = atan2(direction.x, direction.z) - rotation.y
		model.rotation.y = lerp_angle(model.rotation.y, targetAngle, 0.1)
		
		animation_player.play("Walking_B")
	else:
		animation_player.play("Idle")
