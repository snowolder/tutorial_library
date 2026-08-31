extends CharacterBody2D

@onready var fox_animated_sprite: AnimatedSprite2D = $foxAnimatedSprite

const SPEED = 100.0
const JUMP_VELOCITY = -250.0

var onSlowMotion = false

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("interaction"):
		if onSlowMotion:
			onSlowMotion = false
			GlobalData.slowMotionMultiplier = 1.0
		else:
			onSlowMotion = true
			GlobalData.slowMotionMultiplier = 0.1

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	_set_animation()

	move_and_slide()

func _set_animation():
	if velocity.x < 0: fox_animated_sprite.flip_h = true
	elif velocity.x > 0: fox_animated_sprite.flip_h = false

	if velocity.y < 0: fox_animated_sprite.play("jump")
	elif velocity.y > 0: fox_animated_sprite.play("fall")
	elif velocity: fox_animated_sprite.play("move")
	else: fox_animated_sprite.play("idle")
