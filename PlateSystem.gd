extends Node2D
export var nextRoomPath = "Levels/"
var numActivated = 0
var numTotal = 0

func _ready():
	numTotal = get_child_count()-3
	if numTotal == 0:
		openDoor()

func openDoor():
	$Door.open()
	$Door2.open()

func _on_Warp_body_entered(body):
	Global.enterRoom()
	get_node("../Player").saveState()
	get_tree().change_scene("res://" + nextRoomPath + ".tscn")

