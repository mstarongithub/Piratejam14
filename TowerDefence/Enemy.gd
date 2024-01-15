class_name Enemy extends CharacterBody2D

const PHYS_FRAMES_TO_WAIT = 5

@export var data: EnemyData

@onready var _attack_area_shape: CollisionShape2D = $AttackArea/CollisionShape2D
@onready var _attack_cooldown: Timer = $AttackCooldown
@onready var _nav: NavigationAgent2D = $NavigationAgent2D

var health: int
var _can_attack := true
var _physics_frames_passed := 0

func _ready() -> void:
	health = data.base_health
	(_attack_area_shape.shape as CircleShape2D).radius = data.attack_range
	_attack_cooldown.wait_time = data.attack_speed

func deal_damage(dmg: int) -> void:
	health -= dmg
	if health <= 0:
		queue_free()

func _physics_process(_delta: float) -> void:
	var next_target := LiveRunData.get_tower_closest_to(global_position)
	# Can be null, catch that
	if not next_target:
		return
	if next_target.global_position.distance_squared_to(global_position) < data.attack_range**2:
		_attack(next_target)
	else:
		if _physics_frames_passed < PHYS_FRAMES_TO_WAIT:
			_physics_frames_passed += 1
			return
		_nav.target_position = next_target.global_position
		var next := _nav.get_next_path_position()
		velocity = (next - global_position).normalized() * data.base_speed
		move_and_slide()

func _attack(t: Tower) -> void:
	if not _can_attack:
		return
	print("Attacking ", t)
	t.deal_damage(data.base_damage)
	_can_attack = false
	_attack_cooldown.start()

func _on_attack_cooldown_timeout() -> void:
	_can_attack = true
