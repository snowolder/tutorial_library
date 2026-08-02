extends State

const WALK_SPEED = 1.5
const RUN_SPEED = 5

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	var speed = WALK_SPEED
	var direction = player.direction
	
	if Input.is_action_pressed("climb"): speed = RUN_SPEED
	
	if not player.is_on_floor():
		player.velocity.y -= gravity * delta
		
	if direction:
		direction.y = 0
		player.model.look_at(player.position - direction)
		player.velocity.x = direction.x * speed
		player.velocity.z = direction.z * speed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, speed) 
		player.velocity.z = move_toward(player.velocity.z, 0, speed)
		
	if speed > WALK_SPEED and player.velocity: player.animation_player.play("Fast Run")
	elif player.velocity != Vector3.ZERO: player.animation_player.play("Walking")
	else: player.animation_player.play("Idle")
