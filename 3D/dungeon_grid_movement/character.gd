extends CharacterBody3D

@onready var ray_cast_3d: RayCast3D = $RayCast3D
@onready var animation_player: AnimationPlayer = $Knight/AnimationPlayer

const TILE_SIZE = 4.0

var onMove = false
var animationSpeed = 0.7

func _input(_event: InputEvent) -> void:
	var forwardMovement = Input.is_action_just_pressed("ui_up")
	var turnMovement = Input.get_axis("ui_left", "ui_right")
	
	if onMove:
		return
	
	if forwardMovement and not ray_cast_3d.is_colliding():
		_move_forward()
	elif turnMovement:
		_turn(turnMovement)
		
func _move_forward():	
	onMove = true
	var targetPosition = global_position + global_basis.z * TILE_SIZE
	
	var tween = create_tween()
	tween.tween_property(self, "global_position", targetPosition, animationSpeed)
	await tween.finished
	
	onMove = false

func _turn(turnMovement):
	onMove = true
	
	var targetRotation = rotation_degrees
	targetRotation.y -= turnMovement * 90
	
	var tween = create_tween()
	tween.tween_property(self, "rotation_degrees", targetRotation, animationSpeed)
	await tween.finished
	
	onMove = false

func _physics_process(_delta: float) -> void:
	if onMove:
		animation_player.play("Walking_A")
	else:
		animation_player.play("Idle")
