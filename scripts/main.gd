class_name Main
extends Node2D


@onready var menu = $CanvasLayer/Menu
@onready var quiz_creation = $CanvasLayer/QuizCreation
@onready var question_creation = $CanvasLayer/QuestionCreation
@onready var question = $CanvasLayer/Question
@onready var file_dialog:FileDialog = $FileDialog

var current_quiz_data:QuizData

var cur_question:int
var correct_answers:int

func _ready():
	menu.new_quiz_started.connect(create_new_quiz)
	menu.quiz_loaded.connect(quiz_loaded)
	quiz_creation.new_question_added.connect(create_new_question)
	quiz_creation.quiz_saved.connect(quiz_saved)
	question_creation.new_question_created.connect(new_question_created)
	file_dialog.files_selected.connect(quiz_file_selected)


func create_new_quiz():
	current_quiz_data = QuizData.new()
	quiz_creation.start_new_quiz_creation(current_quiz_data)
	menu.visible = false
	quiz_creation.visible = true


func create_new_question():
	quiz_creation.visible = false
	question_creation.clear()
	question_creation.visible = true


func new_question_created(data:QuestionData):
	current_quiz_data.questions.append(data)
	quiz_creation.start_new_quiz_creation(current_quiz_data)
	quiz_creation.visible = true
	question_creation.visible = false


func quiz_saved(data:QuizData):
	DataManager.save_quiz(data)


func quiz_loaded():
	file_dialog.show()


func quiz_file_selected(file):
	var new_data:QuizData = DataManager.load_quiz(file[0])
	start_quiz(new_data)


func start_quiz(quiz_data):
	cur_question = 0
	correct_answers = 0
	question.populate(quiz_data.title, quiz_data.questions[cur_question])
	question.visible = true
	menu.visible = false
