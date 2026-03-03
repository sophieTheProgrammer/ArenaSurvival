class_name Enemy
extends CharacterBody2D

@onready var damage_timer: Timer = $DamageTimer

@export var player: Player
const MOVE_SPEED := 100.0
signal playerHit

var is_damaging := false
var exitingPlayer := false

func _ready() -> void:
	player = Global.player_node
	add_to_group("enemy")
	if not player:
		printerr("no player reference to enemy")

func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	
	velocity = direction * MOVE_SPEED
	
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		is_damaging = true
		damage_timer.start()

# updates exiting player var
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		is_damaging = false

# damages player until exiting player
func _on_damage_timer_timeout() -> void:
	if is_damaging:
		player.lowerHeath(1)
		damage_timer.start()
