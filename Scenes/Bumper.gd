extends Sprite
export var direction = "x"
export var boostSpeed = 4000

func _on_Area2D_body_entered(body):
	if get_parent().get_name() == "BumperBlock":
		direction = get_parent().direction
		boostSpeed = get_parent().boostSpeed
	body.boost(direction, boostSpeed)
