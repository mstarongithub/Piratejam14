extends Projectile

const SPEED = 100

var dir: Vector2
var dmg: int = 100

func setup(inital_target: Node2D, owner: Node2D, damage: int) -> void:
	dir = (inital_target.global_position - owner.global_position).normalized()
	dmg = damage

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Enemy:
		(body as Enemy).deal_damage(dmg)
		queue_free()

func _physics_process(delta: float) -> void:
	position += dir * SPEED
