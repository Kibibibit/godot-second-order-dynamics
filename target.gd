extends Node2D

@onready
var _target_pos: Vector2 = position

@onready
var slider: Slider = $"../Control/VBoxContainer/speed_slider/Slider"
@onready
var label: Label = $"../Control/VBoxContainer/speed_slider/Label"

var mult: float = 10

func _draw():
	draw_circle(position, 10, Color(0,1,0))


func _unhandled_input(event):
	if (event is InputEventMouse):
		if (event.button_mask == MOUSE_BUTTON_LEFT):
			print(event.global_position)
			_target_pos = event.global_position

func _process(delta):
	mult = slider.value
	label.text = "S: %s" % mult
	position = position.move_toward(_target_pos, mult*delta)
	
