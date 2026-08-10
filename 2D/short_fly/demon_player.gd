extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var fly_timer: Timer = $flyTimer

const SPEED = 70.0
const JUMP_VELOCITY = -250.0

var isFlying = false
var wasFlying = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		wasFlying = false

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	_handle_short_fly()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	_set_animation()

	move_and_slide()

func _handle_short_fly():
	if Input.is_action_pressed("ui_accept") and _can_fly():
		isFlying = true
		velocity.y = 0
		if fly_timer.is_stopped():
			fly_timer.start()
	else:
		if isFlying:
			fly_timer.stop()
			fly_timer.timeout.emit()
		isFlying = false

func _can_fly():
	if is_on_floor() or wasFlying or velocity.y < 0:
		return false

	return fly_timer.time_left >= 0

func  _set_animation():
	if velocity.x > 0:
		animated_sprite_2d.flip_h = true
	elif velocity.x < 0:
		animated_sprite_2d.flip_h = false
	
	if isFlying:
		animated_sprite_2d.play("fly")
	elif velocity:
		animated_sprite_2d.play("walking")
	else:
		animated_sprite_2d.play("idle")

func _on_fly_timer_timeout() -> void:
	wasFlying = true
