class_name Player

extends CharacterBody2D

const SPEED := 600.0
const ACCEL := 1.3

const STARTING_HEALTH : float = 20.0

var health := STARTING_HEALTH

var input: Vector2
func _ready() -> void:
	Global.player_node = self
	health = STARTING_HEALTH

func getNormalizedInput():

	input.x = Input.get_axis("left", "right")
	input.y = Input.get_axis("up", "down")
	
	return input.normalized()
	
func lookAtMouse(delta):
	var new_transform := transform.looking_at(get_global_mouse_position())

	transform = transform.interpolate_with(new_transform, 0.1)

func _process(delta: float) -> void:
	if health == 0:
		print("player die")
		get_tree().call_deferred("reload_current_scene")

func _physics_process(delta: float) -> void:	
	# Get the input direction and handle the movement/deceleration.
	getNormalizedInput()
	
	lookAtMouse(delta)

	velocity = lerp(velocity, input * SPEED, delta * ACCEL)

	move_and_slide()

func lowerHeath(healthTaken):
	health -= healthTaken
	print("health is currently ", health)
	
	
