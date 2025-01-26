extends Node2D


@export var occupied_tiles: Array
# yall got a better name?
@export var mort_flesh: int = 200

# Data for tower unlocks and upgrades
@export var tower_store: Dictionary = {
	'projectile': {
		"unlocked": true,
		"upgrades": {
			"range": false,
			"damage": false,
			"rate_of_fire": false,
		},
	},
	'lazer': {
		"unlocked": false,
		"upgrades": {
			"range": false,
			"damage": false,
			"rate_of_fire": false,
		},
	},
	'seismic': {
		"unlocked": false,
		"upgrades": {
			"range": false,
			"damage": false,
			"rate_of_fire": false,
		},
	},
}
