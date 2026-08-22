extends Node2D

@export var characterSprite: Node2D
@export var frequency := 0.2
@export var imageDuration := 1.5

@onready var timer: Timer = $Timer

func start():
	timer.wait_time = frequency
	timer.start()

func stop():
	timer.stop()

func _on_timer_timeout() -> void:
	_add_after_image()
	
func _add_after_image():
	var afterImage: Sprite2D = _get_current_sprite()
	afterImage.modulate.a = 0.75
	afterImage.top_level = true
	
	add_child(afterImage)
	afterImage.global_position = global_position
	
	var tween = create_tween()
	tween.tween_property(afterImage, "modulate:a", 0, imageDuration)
	await tween.finished
	
	afterImage.queue_free()

func _get_current_sprite():
	if characterSprite is AnimatedSprite2D:
		var animation = characterSprite.animation
		var frame = characterSprite.frame
		var texture = characterSprite.sprite_frames.get_frame_texture(animation, frame)
		
		var sprite = Sprite2D.new()
		sprite.texture = texture
		sprite.flip_h = characterSprite.flip_h
		sprite.flip_v = characterSprite.flip_v
		
		return sprite
	else:
		return characterSprite.duplicate()
		
