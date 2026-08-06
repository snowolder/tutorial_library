extends Node2D

@onready var label: Label = $Label

func _ready() -> void:
	for dice in get_tree().get_nodes_in_group("dice"):
		dice.roll_done.connect(_on_dice_roll_done)

func _on_dice_roll_done(_index):
	var dotSum = 0
	
	for dice in get_tree().get_nodes_in_group("dice"):
		dotSum += dice.get_dots()
		
	label.text = str(dotSum)
