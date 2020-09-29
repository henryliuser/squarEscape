extends AnimatedSprite
var activated = false

func open():
	play("doorAct")
	$StaticBody2D.queue_free()
