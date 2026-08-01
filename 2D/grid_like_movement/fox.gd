extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_2d: RayCast2D = $RayCast2D

const TILE_SIZE = 32
const SPEED = 300.0

var onMove = false

func _physics_process(_delta: float) -> void:
	if not onMove:
		var targetPosition = _get_target_position()
		_move_to(targetPosition)
		
	_set_animation()

func _get_target_position():
	var direction = _get_direction()
	
	if direction:
		ray_cast_2d.target_position = direction * TILE_SIZE
		ray_cast_2d.force_raycast_update()
		
		if ray_cast_2d.is_colliding(): return
		
		var targetPosition = global_position + direction * TILE_SIZE
		
		return targetPosition

func _move_to(targetPosition):
	if not targetPosition:
		return
	
	onMove = true
	
	var tween = create_tween()
	tween.tween_property(self, "global_position", targetPosition, 0.3)
	await tween.finished
	
	onMove = false


func _get_direction():
	var direction: Vector2

	if Input.is_action_pressed("ui_up"):
		direction = Vector2.UP
	elif Input.is_action_pressed("ui_down"):
		direction = Vector2.DOWN
	elif Input.is_action_pressed("ui_right"):
		direction = Vector2.RIGHT
	elif Input.is_action_pressed("ui_left"):
		direction = Vector2.LEFT
		
	return direction

func _set_animation():
	var direction = _get_direction()
	
	if direction.x > 0:
		animated_sprite_2d.flip_h = false
	elif direction.x < 0:
		animated_sprite_2d.flip_h = true
	
	if onMove:
		animated_sprite_2d.play("move")
	else:
		animated_sprite_2d.play("idle")
