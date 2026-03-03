extends Control

@onready var timer_number: RichTextLabel = $CanvasLayer/Panel/TimerNumber
@onready var health_bar: ProgressBar = $CanvasLayer/HealthBar
@onready var player = Global.player_node

var time : float =  0.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_bar.value = health_bar.max_value


func _process(delta: float) -> void:
	time += delta	
	timer_number.text = str(snapped(time, 0.1))


func _on_player_health_changed(health: Variant) -> void:
	health_bar.value = 100 * (Global.player_node.health / Global.player_node.STARTING_HEALTH)
