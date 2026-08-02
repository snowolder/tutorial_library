extends CharacterBody3D
class_name PlayerParkour

@onready var model = $Model
@onready var x_bot = $"Model/x-bot"
@onready var animation_player = $"Model/x-bot/AnimationPlayer"
@onready var camera = $Camera
@onready var feet_ray_cast = $Model/FeetRayCast
@onready var climb_finish_ray_cast = $Model/ClimbFinishRayCast
@onready var head_ray_cast = $Model/HeadRayCast
@onready var eye_ray_cast = $Model/EyeRayCast
@onready var left_hand_ray_cast = $Model/LeftHandRayCast
@onready var right_hand_ray_cast = $Model/RightHandRayCast
@onready var collision_shape = $CollisionShape

const JUMP_VELOCITY = 4.5

var direction
var input_dir
var animationPause = false
var nearLadder = false
var canLedgeGrab = false

func _process(delta):
	_check_ray_cast()

func _physics_process(delta):
	input_dir = Input.get_vector("ui_right", "ui_left", "ui_down", "ui_up")
	var cameraBasis = camera.get_camera_transform().basis * Vector3(input_dir.x, 0, input_dir.y) * -1
	direction = cameraBasis.normalized()
	if animationPause: return
	
	move_and_slide()

func _check_ray_cast():
	canLedgeGrab = not head_ray_cast.is_colliding() and eye_ray_cast.is_colliding()
	
	if not feet_ray_cast.is_colliding():
		nearLadder = false
		return
	
	nearLadder = feet_ray_cast.get_collider() is Ladder
