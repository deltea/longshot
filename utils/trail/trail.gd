class_name Trail extends Line2D

@export var emitting = true
@export var length = 40.0

var queue: Array[Vector2]
var point_age = 0.0
const POINT_INTERVAL = 0.016  # Approximately one point per frame at normal speed

func _process(delta: float) -> void:
	if not emitting: return

	point_age += delta

	# Add points based on real time instead of frames
	if point_age >= POINT_INTERVAL:
		point_age = 0.0
		queue.push_front(get_parent().global_position)

		if queue.size() > length:
			queue.pop_back()

		clear_points()
		for point in queue:
			add_point(point)
