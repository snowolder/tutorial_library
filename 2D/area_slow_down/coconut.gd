extends CharacterBody2D

var slowMotionMultiplier = 1.0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		if slowMotionMultiplier == 1.0:
			velocity += get_gravity() * delta
		else:
			velocity = get_gravity() / 2 * slowMotionMultiplier
			
	move_and_slide()

	if get_last_slide_collision():
		queue_free()
