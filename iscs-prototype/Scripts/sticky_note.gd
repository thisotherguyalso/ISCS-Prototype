extends Node2D

var active = false
var dif = Vector2(0, 0)
@onready var audio_player : AudioStreamPlayer = $"Audio Player"
@onready var bottom_color : ColorRect = $BottomColor
@onready var top_color : ColorRect = $Drag/TopColor

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse_position = get_viewport().get_mouse_position()
	if active:
		$".".global_position = mouse_position + dif

func set_audio(stream: AudioStreamWAV, sender: String) -> void:
	audio_player.stream = stream
	$SenderLabel.text = sender  # add a Label node named SenderLabel to your sticky_note scene

func _on_drag_button_down() -> void:
	dif = $".".get_global_position() - get_viewport().get_mouse_position()
	active = true
	DragState.note_active = true

func _on_drag_button_up() -> void:
	active = false
	DragState.note_active = false

func _on_play_pressed():
	$"Audio Player".play()
