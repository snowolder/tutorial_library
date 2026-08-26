extends Node3D

@export var rounds:= 2

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var label_3d: Label3D = $Label3D

var onAction = false
var hasHit = false

func _ready() -> void:
	add_to_group("dummy")

func start_rotation():
	if onAction:
		return
		
	onAction = true
	
	for i in rounds:
		animation_player.play("start")
		await animation_player.animation_finished
		
	onAction = false

func _show_label(text: String):
	label_3d.text = text
	label_3d.show()
	
	await get_tree().create_timer(0.5).timeout
	
	label_3d.hide()

func _on_attack_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		hasHit = true
		_show_label("Hit")


func _on_end_area_area_entered(_area: Area3D) -> void:
	if not animation_player.is_playing(): 
		return
	
	if not hasHit:
		_show_label("Dodge")
	hasHit = false
