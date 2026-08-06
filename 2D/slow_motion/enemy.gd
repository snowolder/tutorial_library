extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var floor_ray_cast: RayCast2D = $FloorRayCast

var speed = 150

var currentDirection = Vector2.RIGHT

func _physics_process(_delta: float) -> void:
	if not floor_ray_cast.is_colliding():
		currentDirection.x *= -1
	
	velocity = currentDirection * speed
	
	_set_animation()
	
	move_and_slide()

func _set_animation():
	if currentDirection.x > 0:
		animated_sprite_2d.flip_h = false
	elif currentDirection.x < 0:
		animated_sprite_2d.flip_h = true
		
	animated_sprite_2d.play("walk")
