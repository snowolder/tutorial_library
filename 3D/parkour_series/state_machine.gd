extends Node

@export var body: PlayerParkour
@export var initialState: STATES

enum STATES {MOVEMENT, CLIMB_LADDER, JUMP, LEDGE_GRAB}

var currentState: STATES

func _ready():
	currentState = initialState if initialState else STATES.MOVEMENT
	get_children()[currentState].set_active(true)
	
func _physics_process(delta):
	if body.animationPause: return
	
	var wantJump = Input.is_action_just_pressed("jump") and body.is_on_floor()
	var isJumping = not body.is_on_floor() and currentState == STATES.JUMP
	
	if body.nearLadder && Input.is_action_pressed("climb"):
		change_state(STATES.CLIMB_LADDER)
	elif currentState == STATES.LEDGE_GRAB and Input.is_action_just_pressed("ui_down"):
		change_state(STATES.MOVEMENT)
	elif isJumping and body.canLedgeGrab or currentState == STATES.LEDGE_GRAB:
		change_state(STATES.LEDGE_GRAB)
	elif wantJump or isJumping:
		change_state(STATES.JUMP)
	else:
		change_state(STATES.MOVEMENT)
		
func change_state(newState):
	if newState == currentState: return
	
	get_children()[currentState].set_active(false)
	currentState = newState
	get_children()[newState].set_active(true)
