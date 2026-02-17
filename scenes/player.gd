extends CharacterBody2D


const SPEED := 600.0
const ACCEL := 1.3

var input: Vector2

func getNormalizedInput():

	input.x = Input.get_axis("left", "right")
	input.y = Input.get_axis("up", "down")
	
	return input.normalized()
	
func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	getNormalizedInput()
	
	velocity = lerp(velocity, input * SPEED, delta * ACCEL)
	

	move_and_slide()
