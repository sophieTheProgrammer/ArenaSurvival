class_name Player

extends CharacterBody2D

@export var Bullet : PackedScene
@onready var muzzle: Marker2D = $Muzzle
@onready var cooldown_timer: Timer = $CoolDownTimer
@onready var safetyCollisionShape: CollisionShape2D = $SafetyZone/CollisionShape2D

const MOUSE_TURN_RATE := 0.175
const SPEED := 650.0
const ACCEL := 1.3
const STARTING_HEALTH : float = 20.0

var shooting_cooldown : float = 0.1
var health := STARTING_HEALTH
var input: Vector2

var can_shoot := true

signal healthChanged(health)
signal died

func _ready() -> void:
	Global.player_node = self
	
	health = STARTING_HEALTH
	cooldown_timer.wait_time = shooting_cooldown

func getNormalizedInput():

	input.x = Input.get_axis("left", "right")
	input.y = Input.get_axis("up", "down")
	
	return input.normalized()
	
func lookAtMouse(delta):
	var new_transform := transform.looking_at(get_global_mouse_position())

	transform = transform.interpolate_with(new_transform, MOUSE_TURN_RATE)

func _process(delta: float) -> void:
	if health == 0:
		print("player died")
		died.emit()
		get_tree().call_deferred("reload_current_scene")
	if Input.is_action_just_pressed("shoot"):
		shoot()

func _physics_process(delta: float) -> void:	
	# Get the input direction and handle the movement/deceleration.
	getNormalizedInput()
	
	if not Global.DEBUG_PLAYER_TURNS_TO_MOUSE:
		lookAtMouse(delta)

	velocity = lerp(velocity, input * SPEED, delta * ACCEL)

	move_and_slide()

func lowerHeath(healthTaken):
	if not Global.DEBUG_HEALTH:
		health -= healthTaken
		healthChanged.emit(health)
		print("health is currently ", health)

func shoot():
	# Instaniate bullet
	if can_shoot:
		var bullet = Bullet.instantiate()
		owner.add_child(bullet)
		bullet.transform = muzzle.global_transform
		
		cooldown_timer.start()
		
		
		#var angle_to_mouse = bullet.global_position.angle_to_point(get_global_mouse_position())
		#print(angle_to_mouse, muzzle.global_rotation)
		#print((muzzle.global_rotation + angle_to_mouse) / 2)
		#muzzle.global_rotation = (muzzle.global_rotation + angle_to_mouse) / 2
		can_shoot = false


func _on_cooldown_timer_timeout() -> void:
	can_shoot = true
