class_name Player
extends Position2D
export (float) var gravity

var speed: Vector2 = Vector2()

func _ready():
	pass


func _physics_process(delta):
	speed.y += gravity * delta
	var movement = speed * delta
	get_node("Body_P1").move_and_slide(movement)
