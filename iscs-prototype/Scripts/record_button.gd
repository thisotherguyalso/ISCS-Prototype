extends Button

@export var sticky_note_scene: PackedScene
@export var name_input: LineEdit  # assign in inspector

var message_board: Node2D
var message_archive: Node2D
var recording := false
var audio_effect: AudioEffectRecord

func _ready() -> void:
	var bus_idx = AudioServer.get_bus_index("Record")
	audio_effect = AudioServer.get_bus_effect(bus_idx, 0)
	message_board = $"../../..".message_board
	message_archive = $"../../..".message_archive

func _pressed() -> void:
	if not recording:
		_start_recording()
	else:
		_stop_recording()

func _start_recording() -> void:
	recording = true
	audio_effect.set_recording_active(true)
	text = "Stop"

func _stop_recording() -> void:
	recording = false
	audio_effect.set_recording_active(false)
	var stream: AudioStreamWAV = audio_effect.get_recording().duplicate()
	var sender := name_input.text.strip_edges()
	if sender == "":
		sender = "Unknown"
	_spawn_note(stream, sender)
	text = "Record"

func _spawn_note(stream: AudioStreamWAV, sender: String) -> void:
	var note = sticky_note_scene.instantiate()
	message_board.add_child(note)
	note.position = Vector2(randf_range(100, 800), randf_range(100, 500))
	note.set_audio(stream, sender)
	message_archive.add_entry(stream, sender)
