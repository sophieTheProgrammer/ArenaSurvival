extends ProgressBar

# Called every frame. 'delta' is the elapsed time since the previous frame.
@onready var player = Global.player_node

func _process(delta: float) -> void:
	value = 100 * (Global.player_node.health / Global.player_node.STARTING_HEALTH)
