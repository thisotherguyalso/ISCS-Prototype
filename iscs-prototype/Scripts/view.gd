extends Camera2D

var dragging := false
var drag_start := Vector2.ZERO
var cam_start := Vector2.ZERO
var velocity := Vector2.ZERO
var last_mouse_pos := Vector2.ZERO

const FRICTION := 0.92
const ZOOM_MIN := Vector2(0.5, 0.5)
const ZOOM_MAX := Vector2(2.0, 2.0)
const ZOOM_STEP := 0.1

var pinch_distance := 0.0

func _input(event: InputEvent) -> void:
	if DragState.note_active:
		dragging = false
		velocity = Vector2.ZERO
		return
	
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			dragging = true
			drag_start = event.position
			cam_start = position
			velocity = Vector2.ZERO
			last_mouse_pos = event.position
		else:
			dragging = false

	if event is InputEventMouseMotion and dragging:
		velocity = cam_start - (event.position - drag_start) - position
		position = cam_start - (event.position - drag_start)
		last_mouse_pos = event.position

	if event is InputEventScreenTouch:
		if event.pressed:
			dragging = true
			drag_start = event.position
			cam_start = position
			velocity = Vector2.ZERO
			last_mouse_pos = event.position
		else:
			dragging = false

	if event is InputEventScreenDrag:
		velocity = cam_start - (event.position - drag_start) - position
		position = cam_start - (event.position - drag_start)
		last_mouse_pos = event.position
	
	# Scroll to zoom
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			_apply_zoom(ZOOM_STEP)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			_apply_zoom(-ZOOM_STEP)
	
	# Pinch to zoom
	if event is InputEventMagnifyGesture:
		_apply_zoom((event.factor - 1.0) * 0.5)

func _apply_zoom(delta: float) -> void:
	zoom = clamp(zoom + Vector2(delta, delta), ZOOM_MIN, ZOOM_MAX)

func reset() -> void:
	dragging = false
	velocity = Vector2.ZERO
	drag_start = Vector2.ZERO
	cam_start = position

func _process(delta: float) -> void:
	if not dragging and velocity.length() > 0.1:
		position += velocity
		velocity *= FRICTION

		# Kill velocity on whichever axis hit the boundary
		var clamped := Vector2(
			clamp(position.x, limit_left, limit_right),
			clamp(position.y, limit_top, limit_bottom)
		)
		if clamped.x != position.x: velocity.x = 0
		if clamped.y != position.y: velocity.y = 0
	elif not dragging:
		velocity = Vector2.ZERO
