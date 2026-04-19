extends Button
var note = preload("res://Scenes/sticky_note.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	print("new note")
	var new_note = note.instantiate()
	add_child(new_note)
