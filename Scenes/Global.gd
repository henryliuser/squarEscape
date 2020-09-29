extends Control

const health = 5
var currentHealth = 5

var totalTime = 0.0
var totalMili = 0
var totalSec = 0
var totalMin = 0

var roomMili = 0
var roomSec = 0
var roomMin = 0
var roomTime = 0.0
var inGame = false
var Timer
var prev
var playerData = [Vector2(),[0,false],[0,false],3]

func hurt():
	currentHealth -= 1
	$CanvasLayer/Timer/Timer3.text = "HP: " + str(currentHealth)


func start():
	totalTime = 0.0
	roomTime = 0.0
	Timer.visible = true
	prev.visible = true
	currentHealth = 5
	$CanvasLayer/Timer/Timer3.text = "HP: " + str(currentHealth)
func done():
	Timer.visible = false
	prev.visible = false
	
func _ready():
	Timer = get_node("/root/Global/CanvasLayer/Timer")
	prev = get_node("/root/Global/CanvasLayer/Timer2")
	Timer.visible = false
	prev.visible = false
	
func enterRoom():
	prev.text = "SPLIT: " + time("[%2s:%2s:%2s]",giveTotalTimes()) + "\n"
	prev.text +="       " + time("(%2s:%2s:%2s)",[roomMin,roomSec,roomMili])
	roomTime = 0.0

func _process(delta):
	updateTimer(delta)
	if Input.is_action_just_pressed("menu"):
		get_tree().change_scene("res://Levels/MainMenu.tscn")
		currentHealth = health
		done()
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

func updateTimer(delta):

	
	totalTime += delta
	roomTime += delta
	
	totalSec = int(totalTime)% 60
	totalMili = 100*(totalTime - totalSec)
	totalMin = int(totalTime / 60)
	
	roomSec = int(roomTime)
	roomMili = 100*(roomTime - roomSec)
	roomMin = int(roomTime / 60)
	Timer.text = time("[%2s:%2s:%2s]",[totalMin,totalSec,totalMili])
	Timer.text += "\n" + time("(%2s:%2s:%2s)",[roomMin,roomSec,roomMili])
	
static func format(var arr):
	var ret = []
	for x in arr:
		var j = ""
		x = int(x)
		if x < 10:
			j = "0" + str(x)
		else:
			j = str(x)
		ret.append(j)
	return ret

func giveTotalTimes():
	return [totalMin,totalSec,totalMili]

static func time(var string, var arr):
	return string % format(arr)

static func lerp_angle(from, to, weight):
	return from + short_angle_dist(from, to) * weight

static func short_angle_dist(from, to):
	var max_angle = PI * 2
	var difference = fmod(to - from, max_angle)
	return fmod(2 * difference, max_angle) - difference
