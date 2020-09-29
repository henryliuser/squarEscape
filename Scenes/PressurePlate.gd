extends AnimatedSprite
var system
var activated = false
func _ready():
	system = get_parent()

func _on_Area2D_body_entered(body):
	if not activated:
		activated = true
		system.numActivated += 1
		if system.numActivated == system.numTotal:
			system.openDoor()
		play("activated1")
