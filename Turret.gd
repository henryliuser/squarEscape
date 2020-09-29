extends Sprite
var delay = 30
var projectileSpeed = 25
var fixed = false
var currentFrame = 0
var system
var skip = 0
var skipCounter = 0


func _ready():
	system = get_parent()
	delay = system.delay 
	projectileSpeed = system.projectileSpeed 
	fixed = system.fixed
	skip = system.skip

func _process(delta):
	currentFrame += 1
	var aim
	if not fixed:
		aim = aim()
	else: aim = system.aim*PI/180
	if currentFrame > 60:
		currentFrame = 1
	if currentFrame % delay == 0:
		shoot(aim)
	
func shoot(aim):
	if skip != 0:
		skipCounter += 1
		if skipCounter == skip:
			skipCounter = 0
		else:
			project(aim)
	else:
		project(aim)

func project(aim):
	
	var scene = load("res://Scenes/Laser.tscn")
	var scene_instance = scene.instance()
	scene_instance.set_name("laser")
	scene_instance.launch(aim,projectileSpeed)
	scene_instance.scale
	system.get_node("Lazors").add_child(scene_instance)

func aim():
	var playerPos = system.get_node("../Player").position
	var dx = system.position.x - playerPos.x
	var dy = system.position.y - playerPos.y
	var rad = atan2(dy,dx)
	orient(rad)
	return rad-PI
	
func orient(rad):
	rad-=PI/2
	rotation = Global.lerp_angle(rotation, rad, 0.5)
	
