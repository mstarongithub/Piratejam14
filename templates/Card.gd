class_name Card extends Resource

@export var effect: Effect
@export var amount: int

func _init(effect_ = null, amount_ = 1):
	effect = effect_
	amount = amount_
