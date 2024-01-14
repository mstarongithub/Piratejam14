@tool
class_name Tower extends Node2D

@export var config: TowerData
## Custom behaviour overwrites targeting and related actions.
## Does not overwrite health handling
@export var custom_behaviour: CustomTowerBehaviour

@onready var _detection_shape: CollisionShape2D = $Area2D/CollisionShape2D
@onready var _sprite_2d: Sprite2D = $Sprite2D

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
	pass

func _ready_engine() -> void:
	pass
	
func _ready_game() -> void:
	(_detection_shape.shape as CircleShape2D).radius = config.range
