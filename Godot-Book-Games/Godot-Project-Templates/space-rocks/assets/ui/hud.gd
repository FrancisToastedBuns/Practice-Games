extends CanvasLayer

signal start_game

@onready var lives_counter = $MarginContainer/HBoxContainer/LivesCounter.get_children()
@onready var score_label = $MarginContainer/HBoxContainer/ScoreLabel
@onready var shield_bar = $MarginContainer/HBoxContainer/ShieldBar
@onready var message = $VBoxContainer/Message
@onready var start_button = $VBoxContainer/StartButton

var bar_textures = {
	"green": preload("res://assets/images/bar_green_200.png"),
	"yellow": preload("res://assets/images/bar_yellow_200.png"),
	"red": preload("res://assets/images/bar_red_200.png")
}
func show_message(text):
	message.text = text
	message.show()
	print("activated")
	$Timer.start()
	
func update_score(value):
	score_label.text = str(value)
	
func update_lives(value):
	for item in 3:
		lives_counter[item].visible = value > item
		
func game_over():
	show_message("Game Over")
	await $Timer.timeout
	start_button.show()


func _on_start_button_pressed():
	start_button.hide()
	start_game.emit()


func _on_timer_timeout():
	message.hide()
	message.text = ""



func _on_player_shield_changed(value) -> void:
	shield_bar.texture_progress = bar_textures["green"]
	if value < 0.4:
		shield_bar.texture_progress = bar_textures["red"]
	elif value < 0.7:
		shield_bar.texture_progress = bar_textures["yellow"]
	shield_bar.value = value
