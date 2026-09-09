extends Node3D

@export var enemies: Array[PackedScene]
@export var spawnType: SPAWN_TYPES = SPAWN_TYPES.WAVES
@export_category("Waves")
@export var nextWaveTime: float = 2.5
@export var enemiesPerWave: int = 4
@export var maxWaves := -1

@export_category("Numbers")
@export var maxNumber:= 3

enum SPAWN_TYPES {WAVES, NUMBER}

@onready var timer: Timer = $Timer

var currentWave = 0
var randomGenerator = RandomNumberGenerator.new()

func _ready() -> void:
	timer.wait_time = nextWaveTime
	
	if spawnType == SPAWN_TYPES.WAVES:
		timer.start()
	else:
		_start_spawn_enemies()

func _start_spawn_enemies():
	await get_tree().create_timer(0.1).timeout
	for i in maxNumber:
		var randomEnemy = enemies.pick_random()
		_spawn_enemy(randomEnemy)

func _spawn_enemy(enemyScene):
		var randomEnemyNode = enemyScene.instantiate()
		get_tree().current_scene.add_child(randomEnemyNode)
		
		if randomEnemyNode.has_signal("died"):
			randomEnemyNode.died.connect(_on_enemy_died)
		
		randomEnemyNode.global_position = _get_random_point()
		
func _on_enemy_died():
	var randomEnemy = enemies.pick_random()
	_spawn_enemy(randomEnemy)

func _on_timer_timeout() -> void:
	for i in enemiesPerWave:
		var randomEnemy = enemies.pick_random()
		_spawn_enemy(randomEnemy)

	currentWave += 1
	
	if currentWave == maxWaves:
		timer.stop()

func _get_random_point():
	var collisionShape: CollisionShape3D = get_child(-1)
		
	if collisionShape.shape is BoxShape3D:
		var halfSize = collisionShape.shape.size / 2
		return collisionShape.global_position + _get_random_point_box_shape(halfSize)
	elif collisionShape.shape is CylinderShape3D:
		var radius = collisionShape.shape.radius
		return collisionShape.global_position + _get_random_point_cylinder_shape(radius)
	elif collisionShape.shape is SphereShape3D:
		var radius = collisionShape.shape.radius
		return collisionShape.global_position + _get_random_point_sphere_shape(radius)

func _get_random_point_box_shape(halfSize):
	var xPos = randomGenerator.randf_range(-halfSize.x, halfSize.x) + global_position.x
	var zPos = randomGenerator.randf_range(-halfSize.z, halfSize.z) + global_position.z

	return Vector3(xPos, global_position.y, zPos)

func _get_random_point_cylinder_shape(radius):
	var randomAngle = randomGenerator.randf_range(0, 2 * PI)
	var randomLength = radius * sqrt(randomGenerator.randf())
	var direction = Vector3.RIGHT.rotated(Vector3.UP, randomAngle)
	
	return direction * randomLength

func _get_random_point_sphere_shape(radius):
	var randomAngle1 = randomGenerator.randf_range(0, 2 * PI)
	var randomAngle2 = randomGenerator.randf_range(0, 2 * PI)
	var randomLength = radius * sqrt(randomGenerator.randf())
	
	var direction = Vector3.RIGHT.rotated(Vector3.UP, randomAngle1)
	direction = direction.rotated(Vector3.RIGHT, randomAngle2)

	return direction * randomLength
		
		
