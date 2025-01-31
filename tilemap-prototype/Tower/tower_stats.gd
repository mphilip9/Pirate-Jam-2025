class_name TowerStats
extends Resource

@export var name: String
@export var info: String
@export var damage: int
@export var speed: int
@export var range: int
@export var tier: int
@export var max_tier: int
@export var preview: bool = true
@export var projectile_scene: PackedScene
@export var rate_of_fire: float
@export var cost: int
@export var preview_texture: AtlasTexture
#@export var preview_sprite

var calculated_range: float:
	get:
		var modifier = 2 if GameData.tower_store[name].upgrades.range else 1
		return range * modifier

var calculated_damage: float:
	get:
		var modifier = 2 if GameData.tower_store[name].upgrades.damage else 1
		return damage * modifier

var calculated_rate_of_fire: float:
	get:
		var modifier = 0.5 if GameData.tower_store[name].upgrades.rate_of_fire else 1
		return rate_of_fire * modifier
