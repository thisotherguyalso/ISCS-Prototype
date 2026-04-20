extends Node

@export var entry_scene: PackedScene
@onready var list = $ScrollContainer/VBoxContainer

func add_entry(stream: AudioStreamWAV, sender: String) -> void:
	var entry = entry_scene.instantiate()
	list.add_child(entry)
	entry.setup(stream, sender, Time.get_datetime_string_from_system())
