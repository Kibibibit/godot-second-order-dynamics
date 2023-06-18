class_name SecondOrderDynamics
extends Node

@export
var _f: float = 1

@export
var _z: float = 0.65

@export
var _r: float = 2

var _k1: float
var _k2: float
var _k3: float

var _delta_crit: float

@onready
var xp: Vector2
@onready
var yd: Vector2 = Vector2(0,0)

var f_slider: Slider
var f_label: Label
var z_slider: Slider
var z_label: Label
var r_slider: Slider
var r_label: Label

func init(start: Vector2):
	
	f_slider = $"../../Control/VBoxContainer/f_slider/Slider"
	f_label = $"../../Control/VBoxContainer/f_slider/Label"
	z_slider =$"../../Control/VBoxContainer/z_slider/Slider"
	z_label = $"../../Control/VBoxContainer/z_slider/Label"
	r_slider = $"../../Control/VBoxContainer/r_slider/Slider"
	r_label = $"../../Control/VBoxContainer/r_slider/Label"
	_calc_k()
	xp = start
	

func _calc_k():
	_z = z_slider.value
	z_label.text = "Z: %s" % _z
	_f = f_slider.value
	f_label.text = "F: %s" % _f
	_r = r_slider.value
	r_label.text = "R: %s" % _r
	
	_k1 = _z / (PI * _f)
	_k2 = 1 / pow(2*PI*_f,2)
	_k3 = _r * _z / (2*PI*_f)
	_delta_crit = 0.8 * (sqrt(4 * _k2 + _k1*_k1) - _k1)


func update(current: Vector2, target: Vector2, delta:float):
	_calc_k()
	var xd = (target - xp) / delta
	xp = target
	var iterations:int = ceili(delta/_delta_crit)
	var delta_t = delta/iterations
	for i in range(0,iterations):
		current = current + (delta_t*yd)
		yd = yd + (delta_t*(target + _k3*xd  - current - _k1*yd )) / _k2;
	return current
