extends Node2D


@export var occupied_tiles: Array
# yall got a better name?: nah this is the currency name now
@export var mort_flesh: int = 200

# wave & stage variable
@export var wave: int = 1
@export var stage: int = 1

# placed tower tracker
@export var placed_turrets = {"projectile": 0, "lazer": 0, "seismic": 0, "hand": 0, "lung": 0, "mouth": 0}
#Tower store related global variables
@export var selected_tower_stats: TowerStats
# Data for tower unlocks and upgrades
@export var tower_store: Dictionary = {
	'projectile': {
		"unlocked": true,
		"upgrades": {
			"range": false,
			"damage": false,
			"rate_of_fire": false,
		},
		"n_upgrades": 0
		
	},
	'lazer': {
		"unlocked": false,
		"upgrades": {
			"range": false,
			"damage": false,
			"rate_of_fire": false,
		},
		"n_upgrades": 0
	},
	'seismic': {
		"unlocked": false,
		"upgrades": {
			"range": false,
			"damage": false,
			"rate_of_fire": false,
		},
		"n_upgrades": 0
	},
	'hand': {
		"unlocked": false,
		"upgrades": {
			"range": false,
			"damage": false,
			"rate_of_fire": false,
		},
		"n_upgrades": 0
	},
	'lung': {
		"unlocked": false,
		"upgrades": {
			"range": false,
			"damage": false,
			"rate_of_fire": false,
		},
		"n_upgrades": 0
	},
	'mouth': {
		"unlocked": true,
		"upgrades": {
			"range": false,
			"damage": false,
			"rate_of_fire": false,
		},
		"n_upgrades": 0
	},
}
#Use this to calculate the price in the store
@export var upgrade_cost_multiplier = {
	"range": 2,
	"damage": 2,
	"rate_of_fire": 2
}
