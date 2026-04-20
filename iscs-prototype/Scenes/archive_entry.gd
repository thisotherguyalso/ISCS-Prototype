extends HBoxContainer

@onready var label = $Label
@onready var play_button = $PlayButton

var stream: AudioStreamWAV

func setup(s: AudioStreamWAV, sender: String, time: String) -> void:
	stream = s
	label.text = sender + " — " + time

func _on_play_button_pressed() -> void:
	var player = AudioStreamPlayer.new()
	add_child(player)
	player.stream = stream
	player.play()
	player.finished.connect(player.queue_free)
