@tool
class_name TowerData extends Resource

## Emitted every time any data has been updated
signal updated

## Coooldown between attacks in seconds
@export var attack_speed: float = 1.0:
	set(new):
		attack_speed = new
		updated.emit()

@export var base_health: int = 100:
	set(new):
		base_health = new
		updated.emit()

## The projectile the tower will spawn
@export var projectile: PackedScene:
	set(new):
		projectile = new
		updated.emit()

## Attack range in pixels
@export var range: int = 100:
	set(new):
		range = new
		updated.emit()

@export var sprite: Texture2D:
	set(new):
		sprite = new
		updated.emit()

@export var base_attack := 20:
	set(new):
		base_attack = new
		updated.emit()
