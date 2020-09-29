extends Label

var totalTime = 0.0
var totalMili = 0
var totalSec = 0
var totalMin = 0

var roomTime = 0.0
var roomMili = 0
var roomSec = 0
var roomMin = 0

func enterRoom():
	roomTime = 0.0

func _process(delta):
	totalTime += delta
	roomTime += delta
	
	totalSec = int(totalTime)
	totalMili = 100*(totalTime - totalSec)
	totalMin = int(totalTime / 60)
	
	roomSec = int(roomTime)
	roomMili = 100*(roomTime - roomSec)
	roomMin = int(roomTime / 60)
	text = "[%2d:%2d:%2d]" % [totalMin,totalSec,totalMili] 
	text += "\n" + "(%2d:%2d:%2d)" % [roomMin,roomSec,roomMili]
