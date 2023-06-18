extends Node2D

var target: Node2D

@onready
var dynamics: SecondOrderDynamics = $"../Target/SecondOrderDynamics"

func _ready():
	target = get_parent().get_node("Target")
	dynamics.init(position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = dynamics.update(position, target.position, delta)


func _draw():
	draw_circle(position, 12, Color(1,0,0))
