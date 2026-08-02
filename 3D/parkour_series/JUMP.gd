extends State

const JUMP_VELOCITY = 4.3

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):	
	if not player.is_on_floor():
		player.velocity.y-= gravity * delta
		
	player.animation_player.play("Jump")

func enter():
	player.velocity.y = JUMP_VELOCITY
