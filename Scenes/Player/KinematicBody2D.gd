extends KinematicBody2D
const debug = true
export var acceleration = 70
export var maxSpeed = 650
const lerpWeight = 0.2
const minSpeed = 4
var velocity = Vector2()

func _physics_process(delta):
	parseInputs()

func _process(delta):
	if debug:
		print(velocity)

func parseInputs():
	var left = Input.is_action_pressed("control_left")
	var right = Input.is_action_pressed("control_right")
	var up = Input.is_action_pressed("control_up")
	var down = Input.is_action_pressed("control_down")
	
	calculateMovement(left, right, up, down)
	

func calculateMovement(left, right, up, down):
	if left and not right:
		velocity.x -= acceleration
		velocity.x = max(velocity.x, -maxSpeed)
	elif right and not left:
		velocity.x += acceleration
		velocity.x = min(velocity.x, maxSpeed)
	else:
		velocity.x = lerp(velocity.x, 0, lerpWeight)
	if abs(velocity.x) < minSpeed: 
		velocity.x = 0
		
		
	if up and not down:
		velocity.y -= acceleration
		velocity.y = max(velocity.y, -maxSpeed)
	elif down and not up:
		velocity.y += acceleration
		velocity.y = min(velocity.y, maxSpeed)
	else:
		velocity.y = lerp(velocity.y, 0, lerpWeight)
	if abs(velocity.y) < minSpeed:
		velocity.y = 0

	velocity = move_and_slide(velocity, Vector2(0,0))
	
	
