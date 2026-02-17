extends CharacterBody2D


const SPEED := 300.0
const JUMP_VELOCITY := -400.0

var input: Vector2

func getNormalizedInput():

	input.x = Input.get_axis("left", "right")
	input.y = Input.get_axis("up", "down")
	
	return input.normalized()
	
func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	getNormalizedInput()
	
	if input:
		velocity.x = input.x * SPEED
		velocity.y = input.y * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	move_and_slide()
