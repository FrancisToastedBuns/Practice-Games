extends CanvasLayer
signal start

func _on_start_button_pressed() -> void:
	$MarginContainer.show()
	$VBoxContainer.hide()
	start.emit()
