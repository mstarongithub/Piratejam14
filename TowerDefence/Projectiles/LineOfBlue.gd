extends Projectile

@onready var line_2d: Line2D = $Line2D

func setup(inital_target: Node2D, owner: Node2D, damage: int) -> void:
	line_2d.clear_points()
	line_2d.add_point(to_local(owner.global_position))
	line_2d.add_point(to_local(inital_target.global_position))
	await get_tree().create_timer(0.15).timeout
	(inital_target as Enemy).deal_damage(damage)
	queue_free()
