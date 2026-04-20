extends HBoxContainer

@onready var message_board = $"../../MessageBoard"
@onready var messenger_screen = $"../../MessengerScreen"
@onready var message_archive = $"../../MessageArchive"

func _ready() -> void:
	_show(message_board)

func _show(target: Node) -> void:
	message_board.visible = message_board == target
	messenger_screen.visible = messenger_screen == target
	message_archive.visible = message_archive == target

	var cam: Camera2D = message_board.get_node("View")
	cam.set_process_input(message_board == target)
	cam.enabled = message_board == target
	if message_board == target:
		cam.reset()

func _on_switch_mb_pressed() -> void:
	_show(message_board)

func _on_switch_ms_pressed() -> void:
	_show(messenger_screen)

func _on_switch_ma_pressed() -> void:
	_show(message_archive)
