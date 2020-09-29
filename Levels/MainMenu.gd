extends Node2D

func _ready():
	Global.currentHealth = Global.health
	Global.playerData = [Vector2(),[0,false],[0,false],3]
	

func _on_Quit_pressed():
	get_tree().quit()


func _on_Play_pressed():
	get_tree().change_scene("res://test.tscn")
	Global.start()
