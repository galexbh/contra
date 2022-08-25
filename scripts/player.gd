class_name Player
extends Position2D
export (float) var gravity
export (float) var motion_speed
export (float) var jump_power

var speed: Vector2 = Vector2()
var is_jumping: bool = false

func _ready():
	pass


func _physics_process(delta):
	speed.y += gravity * delta
	
	if(Input.is_action_pressed("key_d")):
		speed.x = motion_speed
		if(!get_node("Animation_P1").is_playing()):
			get_node("Animation_P1").play("run")
			get_node("Body_P1/Spr_P1").flip_h = false
	elif(Input.is_action_pressed("key_a")):
		speed.x = -motion_speed
		if(!get_node("Animation_P1").is_playing()):
			get_node("Animation_P1").play("run")
			get_node("Body_P1/Spr_P1").flip_h = true
	else:
		speed.x = 0
		if(is_jumping):
			get_node("Animation_P1").play("idle")
	
	if(Input.is_action_pressed("key_space") && is_jumping):
		speed.y = -jump_power
		get_node("Animation_P1").play("jump")
		is_jumping = false
	
	var movement = speed * delta
	get_node("Body_P1").move_and_slide(movement)
	
	if(get_node("Body_P1").get_slide_collision(get_node("Body_P1").get_slide_count()-1) != null):
		var obj_collision = get_node("Body_P1").get_slide_collision(get_node("Body_P1").get_slide_count()-1).collider
		if(obj_collision.is_in_group("floor")):
			if(!is_jumping):
				is_jumping = true
				get_node("Animation_P1").stop()
