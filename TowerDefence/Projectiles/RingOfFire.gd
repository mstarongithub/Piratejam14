extends Projectile

@onready var outside_ring: Area2D = $OutsideRing
@onready var inside_ring: Area2D = $InsideRing

var dmg: int = 100
var frame_count := 0

func setup(inital_target: Node2D, owner: Node2D, damage: int) -> void:
	dmg = damage

func _on_animated_sprite_2d_animation_finished() -> void:
	for i in outside_ring.get_overlapping_bodies():
		if i is Enemy:
			(i as Enemy).deal_damage(dmg)
	queue_free()

func _on_animated_sprite_2d_frame_changed() -> void:
	if frame_count == 3:
		for i in inside_ring.get_overlapping_bodies():
			if i is Enemy:
				(i as Enemy).deal_damage(dmg)
	frame_count += 1
