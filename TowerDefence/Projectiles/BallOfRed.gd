extends Projectile

const SPEED = 200

@onready var character_body_2d: CharacterBody2D = $CharacterBody2D

var dmg := 10

func setup(inital_target: Node2D, owner: Node2D, damage: int) -> void:
	character_body_2d.velocity = (inital_target.global_position - owner.global_position).normalized() * SPEED
	dmg = damage

func _on_timer_timeout() -> void:
	queue_free()

func _physics_process(delta: float) -> void:
	var coll := character_body_2d.move_and_collide(character_body_2d.velocity * delta)
	if not coll:
		return
	var c = coll.get_collider()
	if c is Enemy:
		(c as Enemy).deal_damage(dmg)
		queue_free()
