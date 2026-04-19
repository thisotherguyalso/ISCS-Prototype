extends Button

var effect
var recording
var is_Play

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var index = AudioServer.get_bus_index("Record")
	effect = AudioServer.get_bus_effect(index, 0)

func _on_pressed() -> void:
	if effect.is_recording_active():
		recording = effect.get_recording()
		effect.set_recording_active(false)
		$".".text = "Play"
		is_Play = true
	elif is_Play:
		$"../Audio Player".stop()
		$"../Audio Player".stream = recording
		$"../Audio Player".play()
	else:
		effect.set_recording_active(true)
		$".".text = "Stop"
	
	
