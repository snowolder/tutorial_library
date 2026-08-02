extends Node
class_name State

var active = false
var stateMachine = get_parent()
var player: PlayerParkour
var STATES

func _ready():
	player = get_parent().body
	STATES = get_parent().STATES
	
	set_active(false)
	
func set_active(boolean):
	if boolean: enter()
	elif player.is_node_ready(): exit()
	
	set_physics_process(boolean)
	set_process(boolean)
	
func enter():
	pass
	
func exit():
	pass
	
