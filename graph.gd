extends Node2D


@onready
var dynamics: SecondOrderDynamics = $SecondOrderDynamics
@onready
var pos = Vector2(get_viewport_rect().end.x-450,50)
@onready
var end = pos+Vector2(400,200)



func _draw():
	draw_circle(pos, 5, Color(1,1,1))
	draw_circle(end, 5, Color(1,1,1))
	draw_rect(Rect2(pos,end-pos), Color(0.2,0.2,0.2,0.5))
	
	_graph()
	
func _process(_delta):
	queue_redraw()

func _graph():
	dynamics.init(Vector2(0,0))
	dynamics.yd = Vector2(0,0)
	var previous = Vector2(0,0)
	var target:float = 0.0
	var current:float = 0.0
	var p_current = Vector2(0,0)
	for t in range(0,100):
		var d:float = float(t)/100.0
		if (d > 0.1):
			target = min(10*(d-0.1),0.9)
		else:
			target = 0
		var t_vector= Vector2(d,target)
		current = dynamics.update(Vector2(0,current), Vector2(0,target), 0.05).y
		_line(previous, t_vector, Color(0,0.8,0))
		_line(p_current, Vector2(d, current), Color(0.8,0,0))
		
		previous = t_vector
		p_current = Vector2(d, current)
	
func _line(from: Vector2, to:Vector2, color:Color):
	var _from = Vector2(pos.x+from.x*400, end.y-from.y*200)
	var _to = Vector2(pos.x+to.x*400, end.y-to.y*200)
	draw_line(_from,_to,color)
