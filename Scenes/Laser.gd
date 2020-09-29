extends Area2D
var velocity = Vector2()
var timer = 0 
const visDelay = 5

func _ready():
	$sprite_09.visible = false
	$CollisionPolygon2D.disabled = true
	
func _process(delta):
	position += velocity
	timer += 1
	calcVis()
	
func launch(angle, speed):
	rotation = angle+PI/4
	self.velocity = Vector2(cos(angle),sin(angle))*speed

func calcVis():
	if timer > visDelay:
			$sprite_09.visible = true
			$CollisionPolygon2D.disabled = false
	if timer > 300:
		queue_free()

func _on_Laser_body_entered(body):
	if not body.invincible:
		body.hurtProj(velocity)
		queue_free()
