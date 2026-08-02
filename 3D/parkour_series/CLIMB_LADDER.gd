extends State

const CLIMB_SPEED = 1

func _physics_process(delta):
	var speed = CLIMB_SPEED
	var direction = player.input_dir
	
	if direction:
		player.velocity.y = direction.y * speed
	else:
		player.velocity.y = move_toward(player.direction.x, 0 , speed)	
		
	if player.velocity.y != 0: player.animation_player.play("Climbing")
	else: player.animation_player.stop()

	if player.climb_finish_ray_cast.is_colliding():
		_climb_end()
		set_physics_process(false)
	
func _climb_end():
	var landingPoint = player.climb_finish_ray_cast.get_collision_point()
	player.animationPause = true
	player.animation_player.play("Braced Hang To Crouch")
	
	await get_tree().create_timer(1.2).timeout
	
	player.global_position = landingPoint
	player.animationPause = false	
