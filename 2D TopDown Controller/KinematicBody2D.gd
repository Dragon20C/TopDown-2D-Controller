extends KinematicBody2D

var fps = 60
var speed = 80
var friction = 10
var tile = 16
var h_input = Vector2()
var v_input = Vector2()
var current_dir = Vector2.DOWN
var direcion = Vector2()
onready var animation = $AnimationPlayer
onready var pos_lab = $CanvasLayer/Position

func _ready():
	animation.play("idle Down")

func _physics_process(delta):
	pos_lab.set_text(str(Vector2(int(position.x),int(position.y))))
	h_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	v_input = Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")
	direcion = Vector2(h_input,v_input)
	
	if direcion.x != 0 and direcion.y != 0:
		direcion = Vector2.ZERO
	#direcion = Vector2()
	#if h_input != 0 and v_input == 0:
	#	direcion.x = h_input * speed * delta * fps
	#if v_input != 0 and h_input == 0:
	#	direcion.y = -v_input * speed * delta * fps
	if h_input != 0 and v_input == 0:
		position.x += tile * h_input
	if v_input != 0 and h_input == 0:
		position.y += tile * -v_input
	if h_input == 0:
		#direcion.x = lerp(direcion.x,0,friction * delta)
		if current_dir == Vector2.RIGHT:
			animation.play("idle Right")
		if current_dir == Vector2.LEFT:
			animation.play("idle Left")
	if v_input == 0:
		#direcion.y = lerp(direcion.y,0,friction * delta)
		if current_dir == Vector2.UP:
			animation.play("idle Up")
		if current_dir == Vector2.DOWN:
			animation.play("idle Down")
			
	
	
	#move_and_slide(direcion,Vector2.UP)
