extends Projectile

@onready var line_2d: Line2D = $Line2D

func setup(inital_target: Node2D, owner: Node2D, damage: int) -> void:
	line_2d.clear_points()
	line_2d.add_point(to_local(owner.global_position + Vector2(0, -8)))
	line_2d.add_point(to_local(inital_target.global_position))
	await get_tree().create_timer(0.15).timeout
	if is_instance_valid(inital_target):
		(inital_target as Enemy).deal_damage(damage)
	queue_free()
