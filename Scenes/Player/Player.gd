extends KinematicBody2D

const debug = true

var health = 5

#moving
export var acceleration = 130
export var maxSpeed = 650
var currentMaxSpeed = maxSpeed
const lerpWeight = 0.2
const minSpeed = 4
var velocity = Vector2()
var spinning = false

#dashing
export var dashSpeed = 1600
var dashCooldown = 60
var dashTimer = 0
var dashCDTimer = 0
var dashing = false
var dashReady = true
const totalDashTime = 13
 
#invincibility
const iframes = 60
var iTimer = 0
var invincible = false
const hitStun = 20
var hitStunTimer = 0
var inHitStun = false

var anim


#other
var viewport
var inputs = []


func _physics_process(delta):
	inputs = parseInputs()
	calculateDash(inputs[5])
	if not dashing:
		calculateMovement(inputs[0],inputs[1],inputs[2],inputs[3])
		if not spinning:
			calculateRotation(inputs[4],inputs[6])
		else: spin()
	calculateInvincibility()
	velocity = move_and_slide(velocity,Vector2(0,0))

func _ready():
	enterRoom()
	move_and_slide(velocity)
	anim = $AnimatedSprite
	viewport = get_viewport()

func _process(delta):
	pass


func parseInputs():
	var left = Input.is_action_pressed("control_left")
	var right = Input.is_action_pressed("control_right")
	var up = Input.is_action_pressed("control_up")
	var down = Input.is_action_pressed("control_down")
	var mousePos = viewport.get_mouse_position()
	var pressedDash = Input.is_action_just_pressed("control_dash")
	var locking = Input.is_action_pressed("control_lock")
	var justSpun = Input.is_action_just_pressed("control_spin")
	var spin = Input.is_action_pressed("control_spin")
	
	if spin: 
		if justSpun:
			rotation_degrees += 20
			dashSpeed += 400
		spinning = true
		dashSpeed += 45 #####EVERY LIKE 30 FRAMES OR SOMETHING, CHARGE
		
	else: 
		spinning = false
		dashSpeed = 1600
		
	
	return [left,right,up,down,mousePos,pressedDash,locking,spin]

func calculateInvincibility():
	if invincible:
		iTimer += 1
		if iTimer > iframes:
			anim.play("default")
			invincible = false
			iTimer = 0
	if inHitStun:
		hitStunTimer += 1
		if hitStunTimer > hitStun:
			anim.play("iframes")
			inHitStun = false
			hitStunTimer = 0

func spin():
	rotation_degrees += 8

func calculateMovement(left, right, up, down):
	velocity = lerp(velocity, Vector2(), lerpWeight)
	if not inHitStun: 
		if left and not right:
			if velocity.x > -currentMaxSpeed:
				velocity.x -= acceleration
	
		elif right and not left:
			if velocity.x < currentMaxSpeed:
				velocity.x += acceleration
	
		
		if abs(velocity.x) < minSpeed: 
			velocity.x = 0
	
		if up and not down:
			if velocity.y > -currentMaxSpeed:
				velocity.y -= acceleration
	
		elif down and not up:
			if velocity.y > -currentMaxSpeed:
				velocity.y += acceleration
	
		
		if abs(velocity.y) < minSpeed:
			velocity.y = 0

func calculateRotation(var mousePos, var locking):
	
	var dx = mousePos.x - position.x
	var dy = mousePos.y - position.y
	var thetaRad = atan2(dy,dx) + PI/2
	var currRad = rotation_degrees*PI/180

	

	if locking: 
		thetaRad = calculateLocking(thetaRad)
	
	rotation_degrees = Global.lerp_angle(currRad,thetaRad,0.2) * 180/PI
	var thetaDeg = thetaRad/PI*180
	if abs(rotation_degrees-thetaDeg) <= 1:
		rotation_degrees = thetaDeg

func calculateDash(pressedDash):
	if pressedDash and dashReady:
		anim.play("dashing")
		hitStunTimer = 0
		inHitStun = false
		var rotRad = rotation_degrees * PI/180 - PI/2
		var dashVector = Vector2(cos(rotRad), sin(rotRad)) * dashSpeed
		velocity = dashVector
		dashing = true;
		dashReady = false
		dashSpeed = 1600
	if not dashReady:
		dashCDTimer += 1
		if dashCDTimer >= dashCooldown:
			dashReady = true
			dashCDTimer = 0
	if dashing:
		dashTimer += 1
		if dashTimer > totalDashTime:
			resetDash()

func calculateLocking(mouseRad):
	var options = [0,PI/2,PI,3*PI/2]
	var x = snap(mouseRad,options)
	return -(x-PI/2)

func snap(targetRad, options): #options have to evenly spaced. Returns in degrees

	targetRad = -(targetRad - PI/2)
	if targetRad > PI/4 && targetRad <= 3*PI/4:
		return PI/2
	elif (targetRad > 3*PI/4 && targetRad <= PI) or (targetRad >= -PI && targetRad < -3*PI/4):
		return PI
	elif targetRad >= -3*PI/4 && targetRad < -PI/4:
		return 3*PI/2
	elif (targetRad >= -PI*4 && targetRad < 0) or (targetRad >= 0 && targetRad <= PI/4):
		return 0
	else:
		return 0

#interactions
func hurt():
	
	if not invincible:
		getHurt()
		if velocity.x != 0:
			velocity.x = -velocity.x / abs(velocity.x) * maxSpeed
		if velocity.y != 0:
			velocity.y = -velocity.y / abs(velocity.y) * maxSpeed

func hurtProj(velo):
	if not invincible:
		velocity.x = velo.x/abs(velo.x) * maxSpeed
		velocity.y = velo.y/abs(velo.y) * maxSpeed
		getHurt()

func boost(direction, boostSpeed):
	if dashing:
		resetDash()
	if direction == "x":
		velocity.x = velocity.x * 1.3 + boostSpeed
	if direction == "y":
		velocity.y = velocity.y * 1.3 + boostSpeed

func resetDash():
	anim.play("default")
	dashing = false
	dashTimer = 0

func enterRoom():
	var d = Global.playerData
	velocity = d[0]
	dashTimer = d[1][0]
	dashing = d[1][1]
	iTimer = d[2][0]
	invincible = d[2][1]
	health = d[3]

func saveState():
	Global.playerData = [velocity,[dashTimer,dashing],[iTimer, invincible],health]
	
func getHurt():
	Global.hurt()
	anim.play("hurt")
	health -= 1
	if health == 0:
		get_tree().change_scene("res://Levels/GameOver.tscn")
#	set_collision_layer(0)
	hitStunTimer += 1
	invincible = true
	inHitStun = true
	iTimer +=1
	
	
	
	
