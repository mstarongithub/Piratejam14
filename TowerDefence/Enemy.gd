class_name Enemy extends CharacterBody2D

const PHYS_FRAMES_TO_WAIT = 5

@export var data: EnemyData

@onready var _attack_area_shape: CollisionShape2D = $AttackArea/CollisionShape2D
@onready var _attack_cooldown: Timer = $AttackCooldown
@onready var _nav: NavigationAgent2D = $NavigationAgent2D

var health: int
var _can_attack := true
var _physics_frames_passed := 0
var alive := true
var next_nav

func _ready() -> void:
	health = data.base_health
	(_attack_area_shape.shape as CircleShape2D).radius = data.attack_range
	_attack_cooldown.wait_time = data.attack_speed
	next_nav = global_position

func deal_damage(dmg: int) -> void:
	health -= dmg
	#$debuginfo.text = &"Took %d damage" % dmg
	if health <= 0:
		alive = false
		queue_free()

func _physics_process(_delta: float) -> void:
	if alive:
		var next_target := LiveRunData.get_tower_closest_to(global_position)
		# Can be null, catch that
		if not next_target:
			$debuginfo.text = &""
			return
		$debuginfo.text = &"Moving to: %s" % next_target
		if next_target.global_position.distance_squared_to(global_position) < data.attack_range**2:
			_attack(next_target)
		var cell: Vector2i = Vector2i(floor(global_position / 16.0))
		var tm = get_node("../TileMap")
		var cell_cost = tm.costs[cell].cost if cell in tm.costs else 50.0
		#$debuginfo.text = &"At: %s cost: %s" % [cell, cell_cost]
		if _physics_frames_passed < PHYS_FRAMES_TO_WAIT:
			_physics_frames_passed += 1
			return
		_nav.target_position = next_target.global_position
		var t = Time.get_ticks_msec()
		velocity = (_nav.get_next_path_position() - global_position).normalized() * data.base_speed / (cell_cost * 0.15)
		t = Time.get_ticks_msec() - t
		move_and_slide()
		#update_next_nav()
		$debuginfo.text += &"\n" + str(t)

func _attack(t: Tower) -> void:
	if not _can_attack:
		return
	#print("Attacking ", t)
	$debuginfo.text += &"Attacking: %s" % str(t)
	t.deal_damage(data.base_damage)
	_can_attack = false
	_attack_cooldown.start()

func _on_attack_cooldown_timeout() -> void:
	_can_attack = true
