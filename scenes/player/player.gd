class_name Player extends CharacterBody2D

@export var move_speed = 250.0
@export var active_line_color: Color
@export var turn_speed = 5.0

@onready var line: Line2D = $Line2D
@onready var anchor: Node2D = $Anchor

var start_line_color = Color(1, 1, 1, 1)

func _ready() -> void:
	line.add_point(Vector2(0, 0))
	line.add_point(Vector2(0, 0))

	start_line_color = line.default_color

func _physics_process(delta: float) -> void:
	# var mouse_diff = (get_global_mouse_position() - position).normalized()
	# var mouse_dir = mouse_diff.normalized()

	# line.set_point_position(0, position)
	# line.set_point_position(1, position + mouse_dir * 500)

	# if Input.is_action_just_pressed("fire"):
	# 	Engine.time_scale = 0.1
	# 	line.default_color = active_line_color

	# if Input.is_action_just_released("fire"):
	# 	Engine.time_scale = 1.0
	# 	line.default_color = start_line_color
	# 	velocity = mouse_dir * move_speed

	var x_input = Input.get_axis("left", "right")

	anchor.global_rotation += x_input * turn_speed * delta / Engine.time_scale

	if Input.is_action_just_pressed("fire"):
		Engine.time_scale = 0.1
		line.default_color = active_line_color

	if Input.is_action_just_released("fire"):
		Engine.time_scale = 1.0
		velocity = Vector2.from_angle(anchor.global_rotation) * move_speed

	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
