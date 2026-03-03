extends Node2D

@export var enemy_scene : PackedScene

@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D
@onready var spawn_timer: Timer = $SpawnTimer

var enemySpawnRate: float = 10.0: 
	set(value):
		if spawn_timer:
			enemySpawnRate = value
			spawn_timer.wait_time = enemySpawnRate
		else:
			printerr("spawnTimer doesn't exist")
var area2d_extents

func _ready() -> void:
	spawn_timer.start()
	# assumes shape is rectangle
	area2d_extents = collision_shape_2d.shape.extents
	
	spawn_enemy()
	
	enemySpawnRate = 1.0
	print(enemySpawnRate)
	print(spawn_timer.wait_time)

func _on_spawn_timer_timeout() -> void:
	spawn_enemy()
	spawn_timer.start()

func spawn_enemy():
	var enemy = enemy_scene.instantiate()
	
	enemy.global_position.x = randf_range(area2d_extents.x, -area2d_extents.x)
	enemy.global_position.y = randf_range(area2d_extents.y, -area2d_extents.y) 
	enemy.player = Global.player_node
	add_child(enemy)
