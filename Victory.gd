extends Control

func _ready():
	Global.done()
	var time = $TextureRect/Win2
	time.text = "IN " + Global.time("%2s:%2s:%2s",Global.giveTotalTimes())
	

func _on_Menu_pressed():
	get_tree().change_scene("res://Levels/MainMenu.tscn")
