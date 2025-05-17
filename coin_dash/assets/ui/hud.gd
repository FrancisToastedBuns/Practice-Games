extends CanvasLayer
signal new_game
signal game_over
var player_score = 0
func _process(_delta: float) -> void:
	update_timer()
	update_score()
func _on_button_pressed() -> void:
	$Button.hide()
	$Message.hide()
	$MarginContainer.show()
	new_game.emit()
	
func update_timer():
	$MarginContainer/Timer.text = "Time: " + str(int($Timer.time_left))
func add_time():
	$Timer.start($Timer.time_left + 10)
func update_score():
	$MarginContainer/Score.text = "Score: " + str(player_score)
	
func _on_timer_timeout() -> void:
	game_over.emit()	
func add_score():
	player_score +=1
