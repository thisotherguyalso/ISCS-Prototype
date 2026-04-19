extends Node2D

var active = false
var dif = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse_position = get_viewport().get_mouse_position()
	if active:
		$".".global_position = mouse_position + dif


func _on_drag_button_down() -> void:
	dif = $".".get_global_position() - get_viewport().get_mouse_position()
	active = true


func _on_drag_button_up() -> void:
	active = false
