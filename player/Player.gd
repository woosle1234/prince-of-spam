extends KinematicBody2D

signal spawn_envelope

export (int) var speed = 200
export (float) var fire_delay = 0.1

export (int) var start_effectiveness = 50
export (int) var max_effectiveness = 100

var effectiveness

var velocity = Vector2()

func _ready():
	reset()
	
func reset():
	effectiveness = start_effectiveness
	
	rotation = 0

func get_input():
	look_at(get_global_mouse_position())
	var move_dir = Vector2()
	if Input.is_action_pressed('down'):
		move_dir += Vector2(-1, 0)
	if Input.is_action_pressed('up'):
		move_dir += Vector2(1, 0)
	if Input.is_action_pressed('left'):
		move_dir += Vector2(0, -1)
	if Input.is_action_pressed('right'):
		move_dir += Vector2(0, 1)
	velocity = (move_dir.normalized() * speed).rotated(rotation)
		
	if Input.is_action_pressed('primary_action') and $fire_timer.is_stopped():
		emit_signal('spawn_envelope', $gun_position.global_position, rotation)
		$fire_timer.start()

func _physics_process(delta):
	get_input()
	move_and_slide(velocity)
