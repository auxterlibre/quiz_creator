class_name QuizCreation
extends Control

signal new_question_added
signal quiz_saved

@onready var quiz_name:TextEdit = $QuizName
@onready var add_question_button:Button = $ScrollContainer/Questions/AddQuestionButton
@onready var questions:VBoxContainer = $ScrollContainer/Questions
@onready var warning:Label = $Warning
@onready var save_quiz_button:Button = $SaveQuizButton


var quiz_data:QuizData

func _ready():
	add_question_button.pressed.connect(_on_add_question_pressed)
	save_quiz_button.pressed.connect(_on_save_pressed)


func start_new_quiz_creation(data:QuizData):
	warning.text = ""
	quiz_data = data
	for question in data.questions:
		add_question_to_list(question)


func add_question_to_list(question:QuestionData):
	var question_btn:Button = Button.new()
	question_btn.text = question.question
	questions.add_child(question_btn)
	questions.move_child(question_btn, questions.get_child_count() - 2)


func _on_add_question_pressed():
	new_question_added.emit()


func _on_save_pressed():
	warning.text = ""
	if quiz_name.text == "":
		warning.text = "O quiz precisa de um nome"
	elif questions.get_child_count() == 1:
		warning.text = "Ao menos uma pergunta é necessária para salvar o quiz"
	else:
		quiz_data.title = quiz_name.text
		quiz_saved.emit(quiz_data)
