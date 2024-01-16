@tool
class_name Tower extends Sprite2D

const DEFAULT_PROJECTILE = preload("res://TowerDefence/DefaultProjectile.tscn")

signal died

## Information about the tower such as attack speed, range and projectile fired
@export var config: TowerData:
	set(new):
		config = new
		_reload_from_data()
## Custom behaviour overwrites targeting and related actions.
## Does not overwrite health handling
@export var custom_behaviour: CustomTowerBehaviour

@onready var _detection_shape: CollisionShape2D = $Area2D/CollisionShape2D
@onready var _detection_area: Area2D = $Area2D
@onready var _attack_cooldown: Timer = $AttackCooldown
@onready var _navigation_obstacle_2d: NavigationObstacle2D = $NavigationObstacle2D

var _health: int = 100
var is_dead := false
var _can_attack := true
var _ready_game_done := false

func _ready() -> void:
	if Engine.is_editor_hint():
		_ready_engine()
	else:
		_ready_game()

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		_process_editor(delta)
	else:
		_process_game(delta)

func _process_editor(_delta: float) -> void:
	Util.snap_to_tilemap(self)

func _process_game(_delta: float) -> void:
	if is_dead:
		return

func _ready_engine() -> void:
	_detection_shape.shape = _detection_shape.shape.duplicate()
	
func _ready_game() -> void:
	LiveRunData.register_tower(self)
	_ready_game_done = true
	_reload_from_data()

func _reload_from_data() -> void:
	if not Engine.is_editor_hint() and not _ready_game_done:
		return
	if not config:
		return
	if not config.updated.is_connected(_reload_from_data):
		config.updated.connect(_reload_from_data)
	if config.sprite:
		texture = config.sprite
	(_detection_shape.shape as CircleShape2D).radius = config.range
	_health = config.base_health
	print(config.base_health)
	_attack_cooldown.wait_time = config.attack_speed

## For removing self from the list of existing towers in case of deletion
## Tower should have removed self before it gets deleted, but just to be sure, do it again
## remove_tower won'T do anything if already gone
func _notification(what: int) -> void:
	if Engine.is_editor_hint():
		return
	if what == NOTIFICATION_PREDELETE:
		LiveRunData.remove_tower(self)

func _physics_process(_delta: float) -> void:
	if Engine.is_editor_hint() or is_dead:
		return
	var targets: Array[Enemy] = []
	for i in _detection_area.get_overlapping_bodies():
		if i is Enemy:
			targets.append(i as Enemy)
	if len(targets) == 0:
		return
	targets.sort_custom(func(x: Enemy, y: Enemy):
		return x.global_position.distance_squared_to(global_position) < \
		y.global_position.distance_squared_to(global_position)
	)
	_attack(targets[0])

func _attack(e: Enemy) -> void:
	if _can_attack:
		var projectile: Projectile
		if config and config.projectile:
			projectile = config.projectile.instantiate() as Projectile
		else:
			projectile = DEFAULT_PROJECTILE.instantiate() as Projectile
		add_child(projectile)
		projectile.setup(e, self, config.base_attack if config else 20)
		_can_attack = false
		_attack_cooldown.start()

func _on_attack_cooldown_timeout() -> void:
	_can_attack = true

func deal_damage(dmg: int) -> void:
	if _health <= 0:
		print("Health below 0")
		return
	_health -= dmg
	if _health <= 0:
		_on_death()
		

func _on_death() -> void:
	died.emit()
	is_dead = true
	LiveRunData.remove_tower(self)
	$StaticBody2D/CollisionShape2D.disabled = true

func _to_string():
	return &"%s at %s" % [name, global_position]
