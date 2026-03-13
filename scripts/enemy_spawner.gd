extends Node2D

@export var enemy_scene : PackedScene

@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D
@onready var spawn_timer: Timer = $SpawnTimer
@onready var polygon_2d: Polygon2D = $Polygon2D

var enemySpawnRate: float = 0.75: 
	set(value):
		if spawn_timer:
			enemySpawnRate = value
			spawn_timer.wait_time = enemySpawnRate
		else:
			printerr("spawnTimer node doesn't exist")
var area2d_extents

var waveEnemiesSpawned: int = 0
var waveSlowEnemiesSpawned: int = 0
var enemySpawnCounter : float = 0
var slowEnemySpawnCounter : float = 0

signal spawnTimerTimeout
signal waveEnded

func _ready() -> void:
	spawn_timer.wait_time = enemySpawnRate
	# assumes shape is rectangle
	area2d_extents = collision_shape_2d.shape.extents
	
	# spawns starting enemies
	start_wave(3)


func _on_spawn_timer_timeout() -> void:
	spawnTimerTimeout.emit()

# floors the float fyi
func spawn_enemy(amount: float, type : Global.ENEMY_TYPE):
	for i in range(floor(amount)):
		var enemy : Enemy = enemy_scene.instantiate()
		enemy.player = Global.player_node
		
		var iter = 0
		
		enemy.global_position.x = randf_range(area2d_extents.x, -area2d_extents.x)
		enemy.global_position.y = randf_range(area2d_extents.y, -area2d_extents.y) 
			
		add_child(enemy)
		
		# while loop to make sure enemy not in safety zone
		while Global.player_node.safetyCollisionShape.shape.get_rect().has_point(enemy.global_position):
			
			enemy.get_node("Polygon2D").color = Color.BLUE
			
			enemy.global_position.x = randf_range(area2d_extents.x, -area2d_extents.x)
			enemy.global_position.y = randf_range(area2d_extents.y, -area2d_extents.y) 
			
			iter += 1
			print(iter, " relocating enemy due to bad placement, in player safezone?")
	
func start_wave(wave_number):
	var wave = Global.STAGE_SPAWNS[wave_number]
	waveEnemiesSpawned = 0
	waveSlowEnemiesSpawned = 0
	print("STARTING WAVE: " + str(wave_number) + " - WAVE DATA: " + str(wave))
	
	if not wave:
		printerr("index on start_wave didn't get a stage")
	if Global.ui_node:
		Global.ui_node.show_stage_label(wave_number)
	else:
		printerr("no global ui_node reference in enemy_spawner")
	
	# spawn enemies until enemies above cap
	while wave.normal_enemies_cap > waveEnemiesSpawned: #or wave.slow_enemies_cap > waveSlowEnemiesSpawned:
		spawn_timer.start()
		
		await spawnTimerTimeout
		spawn_enemy(1, Global.ENEMY_TYPE.FAST)
		Global.enemiesAmount += 1 
		waveEnemiesSpawned += 1
		print("spawnTimer timed out now adding enemy: ", waveEnemiesSpawned)
	print("finished spawning enemies")
