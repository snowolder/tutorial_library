extends CharacterBody3D

signal died()

@onready var animation_player: AnimationPlayer = $Barbarian/AnimationPlayer

var speed = 5.0
var target: CharacterBody3D

func _physics_process(_delta: float) -> void:
	target = get_tree().get_first_node_in_group("player")

	if not target:
		return
	
	var direction = global_position.direction_to(target.global_position)
	velocity = direction * speed
		
	velocity.y = 0
	
	look_at(target.global_position, Vector3.UP, true)
		
	_set_animation()
	
	move_and_slide()

	var lastCollision = get_last_slide_collision().get_collider()
	if get_last_slide_collision() and lastCollision in get_tree().get_nodes_in_group("player"):
		_die()
		
func _die():
	set_physics_process(false)
	animation_player.play("Death_A")
	
	await animation_player.animation_finished
	
	died.emit()
	
	queue_free()

func _set_animation():
	if velocity:
		animation_player.play("Walking_A")
	else:
		animation_player.play("Idle")
