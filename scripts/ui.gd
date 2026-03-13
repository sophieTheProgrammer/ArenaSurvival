class_name ui

extends Control

@onready var timer_number: RichTextLabel = $CanvasLayer/Panel/TimerNumber
@onready var health_bar: ProgressBar = $CanvasLayer/HealthBar
@onready var player = Global.player_node
@onready var stage_label: RichTextLabel = $CanvasLayer/StageLabel
@onready var enemy_num: RichTextLabel = $CanvasLayer/EnemyNum

var time : float =  0.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_bar.value = health_bar.max_value
	Global.ui_node = self

func _process(delta: float) -> void:
	time += delta	
	timer_number.text = str(snapped(time, 0.1))

	enemy_num.text = "amount of enemies rn is: " + str(Global.enemiesAmount)
func _on_player_health_changed(health: Variant) -> void:
	health_bar.value = 100 * (Global.player_node.health / Global.player_node.STARTING_HEALTH)

func show_stage_label(number: int):
	stage_label.visible = true
	stage_label.text = "Stage: " + str(number)
	await get_tree().create_timer(2.0).timeout
	stage_label.visible = false
