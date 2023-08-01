class_name Menu
extends Control

signal new_quiz_started
signal quiz_loaded

@onready var new_quiz_button:Button = $NewQuizButton
@onready var load_quiz_button:Button = $LoadQuizButton


func _ready():
	new_quiz_button.pressed.connect(_on_new_quiz_pressed)
	load_quiz_button.pressed.connect(_on_load_quiz_pressed)


func _on_new_quiz_pressed():
	new_quiz_started.emit()


func _on_load_quiz_pressed():
	quiz_loaded.emit()
