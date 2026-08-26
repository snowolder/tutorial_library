extends CharacterBody3D

@onready var animation_player: AnimationPlayer = $model/AnimationPlayer
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D

var onAction = false

func _ready() -> void:
	add_to_group("player")
	
	animation_player.speed_scale = 1.5


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("movement_right") and not onAction:
		_hit()
	elif Input.is_action_just_pressed("movement_left") and not onAction:
		_dodge()

func _hit():
	onAction = true

	animation_player.play("1H_Melee_Attack_Stab")
	_activate_dummy()
	
	await animation_player.animation_finished

	onAction = false

func _activate_dummy():
	await get_tree().create_timer(0.8).timeout
	
	var dummy = get_tree().get_first_node_in_group("dummy")
	dummy.start_rotation()

func _dodge():
	onAction = true
	
	collision_shape_3d.disabled = true
	
	animation_player.play("Dodge_Backward")
	await animation_player.animation_finished
	animation_player.play_backwards("Dodge_Backward")
	await animation_player.animation_finished
	
	collision_shape_3d.disabled = false
	
	onAction = false
