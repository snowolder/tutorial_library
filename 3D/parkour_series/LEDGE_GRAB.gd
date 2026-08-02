extends State

const MOVE_SPEED = 1
const ledge_jump_height = 2
const JUMP_VELOCITY = 4.3

func enter():
	player.velocity = Vector3.ZERO
	
	player.collision_shape.shape.height = 1
	
func _physics_process(delta):
	var input = player.input_dir
	var direction = player.model.transform.basis * Vector3(input.x, 0, input.y)
	
	if Input.is_action_pressed("climb") and input:
		get_parent().change_state(get_parent().STATES.JUMP)
		return 
	
	if direction.x:
		var oldPosition = player.head_ray_cast.get_collision_point()
		var newPosition
		
		if input.x == -1 and player.right_hand_ray_cast.is_colliding():
			newPosition = player.right_hand_ray_cast.get_collision_point()
		elif input.x == 1 and player.left_hand_ray_cast.is_colliding():
			newPosition = player.left_hand_ray_cast.get_collision_point()
		else: player.velocity = Vector3.ZERO
		
		if newPosition:
			player.velocity = (newPosition - oldPosition).normalized() * MOVE_SPEED
			player.velocity.y = 0
	else:
		player.velocity = Vector3.ZERO
	
	_set_animation(input)

func _set_animation(input):
	var animationIdleOffSetY = -0.3
	var animationMoveOffSetY = -0.5
	player.x_bot.position.y = 0
	
	if player.velocity:
		player.x_bot.position.y = animationMoveOffSetY
		
		if input.x > 0:
			player.animation_player.play("Braced Hang left")
		else:
			player.animation_player.play("Braced Hang right")
	else:
		player.model.position.y = animationIdleOffSetY
		player.animation_player.play("Hanging Idle")	

func exit():
	player.collision_shape.shape.height = 2
	player.velocity = Vector3.ZERO
	player.model.position.y = 0
	player.x_bot.position.y = 0

func _check_ledge_jump():
	var rayCastCopy = player.head_ray_cast.duplicate()
	player.add_child(rayCastCopy)
	rayCastCopy.position = player.head_ray_cast.position
	rayCastCopy.rotation_degrees = player.model.rotation_degrees
	
	var checkHeight = 0
	
	while checkHeight < ledge_jump_height:
		rayCastCopy.position.y += 0.1
		rayCastCopy.force_raycast_update()
		checkHeight += 0.1
		
		if rayCastCopy.is_colliding(): 
			return rayCastCopy.get_collision_point()
		print(rayCastCopy.position.y)
	
	rayCastCopy.queue_free()
	
