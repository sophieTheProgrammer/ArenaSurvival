class_name Player

extends CharacterBody2D

const SPEED := 600.0
const ACCEL := 1.3

var health := 1

var input: Vector2

func getNormalizedInput():

	input.x = Input.get_axis("left", "right")
	input.y = Input.get_axis("up", "down")
	
	return input.normalized()
	
func lookAtMouse(delta):
	var new_transform := transform.looking_at(get_global_mouse_position())

	transform = transform.interpolate_with(new_transform, 0.1)
	
func _physics_process(delta: float) -> void:	
	# Get the input direction and handle the movement/deceleration.
	getNormalizedInput()
	
	lookAtMouse(delta)

	velocity = lerp(velocity, input * SPEED, delta * ACCEL)

	move_and_slide()

# hit by enemy oh no dying
func _on_enemy_player_hit() -> void:
	get_tree().reload_current_scene()
