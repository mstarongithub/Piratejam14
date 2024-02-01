@tool
class_name TowerData extends Resource

## Emitted every time any data has been updated
signal updated

## Coooldown between attacks in seconds
@export_range(0.01, 2.0) var attack_speed: float = 1.0:
	set(new):
		attack_speed = new
		updated.emit()

@export_range(10, 300, 1) var base_health: int = 100:
	set(new):
		base_health = new
		updated.emit()

## The projectile the tower will spawn
@export var projectile: PackedScene:
	set(new):
		projectile = new
		updated.emit()

## Attack range in pixels
@export_range(8, 200, 1) var attack_range: int = 100:
	set(new):
		attack_range = new
		updated.emit()

@export var sprite: Texture2D:
	set(new):
		sprite = new
		updated.emit()

@export var destroyed_sprite: Texture2D:
	set(new):
		destroyed_sprite = new
		updated.emit()

@export_range(1, 100, 1) var base_attack: int = 20:
	set(new):
		base_attack = new
		updated.emit()
