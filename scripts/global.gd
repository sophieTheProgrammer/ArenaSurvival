extends Node

var enemiesAmount : int = 0 

var player_node : Player = null
var ui_node = null
# player does not lose health
const DEBUG_HEALTH = false

# enemy doesn't move
const DEBUG_ENEMY_MOVEMENT = false

const DEBUG_PLAYER_TURNS_TO_MOUSE = false

enum ENEMY_TYPE {
	FAST,
	SLOW
}
# spawn timer happens every second, increment conut of how many spawn per second

# spawn enemies and increment count

# sps spawned per second

const STAGE_SPAWNS = {
	1: {
		"normal_enemies_cap" = 10,
		"normal_enemies_sps" = 0.65,
		"slow_enemies_cap" = 0,
		"slow_enemies_sps" = 0,
	},
	2: {
		"normal_enemies_cap" = 10,
		"normal_enemies_sps" = 0.9,
		"slow_enemies_cap" = 0,
		"slow_enemies_sps" = 0,
	},
	3: {
		"normal_enemies_cap" = 13,
		"normal_enemies_sps" = 1,
		"slow_enemies_cap" = 1,
		"slow_enemies_sps" = 0.25,
	},
	4: {
		"normal_enemies_cap" = 20,
		"normal_enemies_sps" = 1.2,
		"slow_enemies_cap" = 3,
		"slow_enemies_sps" = 0.5,
	},
	5: {
		"finished" : true
	}
}
