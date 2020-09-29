extends StaticBody2D
export var xPatrol = [0,1]
export var yPatrol = [0,1]


func _physics_process(delta):
	position += constant_linear_velocity
	if position.x > xPatrol[1] or position.x < xPatrol[0]:
		constant_linear_velocity.x *= -1
	if position.y > yPatrol[1] or position.y < yPatrol[0]:
		constant_linear_velocity.y *= -1
	rotation_degrees += constant_angular_velocity*100*delta
