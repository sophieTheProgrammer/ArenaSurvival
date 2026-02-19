class_name Enemy
extends CharacterBody2D

@export var player: Player
const MOVE_SPEED := 100.0

func _ready() -> void:
	if not player:
		printerr("no player reference to enemy")

func _physics_process(delta: float) -> void:
	var direction = position.direction_to(player.global_position)
	
	velocity = direction * MOVE_SPEED
	
	move_and_slide()
