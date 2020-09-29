extends Control

func _ready():
	Global.done()


func _on_Button_pressed():
	get_tree().change_scene("res://Levels/MainMenu.tscn")
