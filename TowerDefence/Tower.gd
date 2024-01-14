class_name Tower extends Node2D

@export var config: TowerData
## Custom behaviour overwrites targeting and related actions.
## Does not overwrite health handling
@export var custom_behaviour: CustomTowerBehaviour

@onready var detection_shape: CollisionShape2D = $Area2D/CollisionShape2D

func _ready() -> void:
	(detection_shape.shape as CircleShape2D).radius = config.range
