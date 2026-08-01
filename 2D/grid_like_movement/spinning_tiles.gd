@tool
extends Area2D

@export var direction: DIRECTIONS = DIRECTIONS.UP:
	set(value):
		direction = value
		_change_sprite()
		
@onready var sprites: Node2D = $sprites

enum DIRECTIONS {UP, DOWN, LEFT, RIGHT}

func _ready() -> void:
	_change_sprite()

func _change_sprite():
	if not is_node_ready():
		return
		
	for i in sprites.get_child_count():
		sprites.get_child(i).visible = i == direction
		

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		pass
