extends PanelContainer

@export var styleBoxSelected: StyleBox
@export var styleBoxUnselected: StyleBox

@onready var level_label: Label = %levelLabel
@onready var icon: TextureRect = $MarginContainer/VBoxContainer/icon

const CHECK = preload("uid://dbnvm4tb1ss3y")
const PADLOCK = preload("uid://cganrn6vdthrl")

var animationSpeed = 0.1

var levelNumber: int = -1:
	set(value):
		levelNumber = value
		%levelLabel.text = str(value)

func set_lock():
	icon.modulate.a = 1
	icon.texture = PADLOCK
	
func set_open():
	icon.modulate.a = 0

func set_done():
	icon.modulate.a = 1
	icon.texture = CHECK

func _on_mouse_entered() -> void:
	add_theme_stylebox_override("panel", styleBoxSelected)
	
	var tween := create_tween()
	tween.tween_property(self, "offset_transform_rotation",deg_to_rad(10), animationSpeed)
	tween.parallel()
	tween.tween_property(self, "offset_transform_position",Vector2(0,-10), animationSpeed)


func _on_mouse_exited() -> void:
	add_theme_stylebox_override("panel", styleBoxUnselected)

	var tween := create_tween()
	tween.tween_property(self, "offset_transform_rotation",deg_to_rad(0), animationSpeed)
	tween.parallel()
	tween.tween_property(self, "offset_transform_position",Vector2(0,0), animationSpeed)

# only for showcase
func _on_gui_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("leftClick"):
		set_done()
		
		SaveManager.levelList[get_index()].done = true
		SaveManager.save_game()
