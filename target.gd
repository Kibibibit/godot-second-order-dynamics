extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _draw():
	draw_circle(position, 10, Color(0,1,0))


func _unhandled_input(event):
	if (event is InputEventMouse):
		if (event.button_mask == MOUSE_BUTTON_LEFT):
			position = event.global_position
