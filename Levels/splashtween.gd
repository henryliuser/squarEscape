extends Tween
onready var E = get_node("../E")
onready var Title = get_node("../Title")
onready var red = get_node("../sprite_06")
onready var green = get_node("../sprite_05")
onready var purp = get_node("../sprite_11")

func _ready():
	interpolate_property(E, "custom_fonts/font:outline_size", 10,
		22, 2, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	interpolate_property(E, "custom_fonts/font:outline_size", 22,
		10, 2, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT, 2)
	interpolate_property(Title, "custom_fonts/font:outline_size", 10,
		22, 2, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	interpolate_property(Title, "custom_fonts/font:outline_size", 22,
		10, 2, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT, 2)
	interpolate_property(red, "rotation_degrees", 0, 360, 4,
		Tween.TRANS_CUBIC, Tween.EASE_OUT)
	interpolate_property(green, "rotation_degrees", -217, -217+360, 4,
		Tween.TRANS_SINE, Tween.EASE_IN)
		
	var inc = 20
	for c in purp.get_children():
		interpolate_property(c, "position:y", c.position.y, 
		c.position.y-inc, 2, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
		interpolate_property(c, "position:y", c.position.y-inc, 
		c.position.y, 2, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT,2)
		inc -= 4
	interpolate_property(purp, "rotation_degrees", -3, 3,2,Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	interpolate_property(purp, "rotation_degrees", 3, -3, 2,Tween.TRANS_CUBIC, Tween.EASE_IN_OUT,2)
	start()
