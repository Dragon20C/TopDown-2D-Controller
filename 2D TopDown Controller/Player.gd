extends KinematicBody2D

var speed = 5
const tile = 16
var h_input = 0
var v_input = 0
var last_position = Vector2()
var next_pos = 0
var direction = Vector2()
var moving = false
var ani_dir = "right"
onready var animation = $AnimationPlayer
onready var pos_lab = $CanvasLayer/Position

func _ready():
	animation.play("idle Down")
	last_position = position
	
func _physics_process(delta):
	pos_lab.set_text(str(Vector2(int(position.x),int(position.y))))
	if moving == false:
		player_input()
	elif direction != Vector2.ZERO:
		move(delta)
	else:
		moving = false
	
func player_input():
	if v_input == 0:
		h_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if h_input == 0:
		v_input = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	direction = Vector2(h_input,v_input) # Combine x and y button presses
	
	if direction != Vector2.ZERO: # if moving set last position to current position and move true
		last_position = position
		moving = true
	#Animations
	if h_input == 0:
		#direcion.x = lerp(direcion.x,0,friction * delta)
		if ani_dir == "right":
			animation.play("idle Right")
		if ani_dir == "left":
			animation.play("idle Left")
	if v_input == 0:
		#direcion.y = lerp(direcion.y,0,friction * delta)
		if ani_dir == "up":
			animation.play("idle Up")
		if ani_dir == "down":
			animation.play("idle Down")
	
	if h_input > 0 and v_input == 0:
		animation.play("walking Right")
		ani_dir = "right"
	elif h_input < 0 and v_input == 0:
		animation.play("walking Left")
		ani_dir = "left"
	elif v_input < 0 and h_input == 0:
		animation.play("walking Up")
		ani_dir = "up"
	elif v_input > 0 and h_input == 0:
		animation.play("walking Down")
		ani_dir = "down"
func move(delta): # Actually makes the player move to next position
	next_pos += speed * delta
	if next_pos >= 1.0:
		position = last_position + (tile * direction)
		next_pos = 0
		moving = false
	else:
		position = last_position + (tile * direction * next_pos)
