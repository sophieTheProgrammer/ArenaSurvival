extends Node2D

@export var enemy_scene : PackedScene

@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D
@onready var spawn_timer: Timer = $SpawnTimer
@onready var polygon_2d: Polygon2D = $Polygon2D
@onready var complexity_timer: Timer = $ComplexityTimer

var enemySpawnRate: float = 2.5: 
	set(value):
		if spawn_timer:
			enemySpawnRate = value
			spawn_timer.wait_time = enemySpawnRate
		else:
			printerr("spawnTimer node doesn't exist")
var area2d_extents
var enemySpawnAmount : float = 1.0

func _ready() -> void:
	spawn_timer.wait_time = enemySpawnRate
	spawn_timer.start()
	complexity_timer.start()
	# assumes shape is rectangle
	area2d_extents = collision_shape_2d.shape.extents
	
	# spawns starting enemies
	spawn_enemy(1)


func _on_spawn_timer_timeout() -> void:
	spawn_enemy(enemySpawnAmount)
	spawn_timer.start()

# floors the float fyi
func spawn_enemy(amount: float):
	for i in range(floor(amount)):
		var enemy : Enemy = enemy_scene.instantiate()
		enemy.player = Global.player_node
		
		var iter = 0
		
		enemy.global_position.x = randf_range(area2d_extents.x, -area2d_extents.x)
		enemy.global_position.y = randf_range(area2d_extents.y, -area2d_extents.y) 
			
		add_child(enemy)
		
		# while loop to make sure enemy not in safety zone
		while Global.player_node.safetyCollisionShape.shape.get_rect().has_point(enemy.global_position):
			
			# enemy.get_node("Polygon2D").color = Color.BLUE
			
			enemy.global_position.x = randf_range(area2d_extents.x, -area2d_extents.x)
			enemy.global_position.y = randf_range(area2d_extents.y, -area2d_extents.y) 
			
			iter =+ 1
			print(iter, "iter")
	

# increment complexity every time this runs out
func _on_complexity_timer_timeout() -> void:
	enemySpawnRate -= 0.5
	enemySpawnAmount += 0.5
	
	complexity_timer.start()
