class_name Question
extends Control

@onready var quiz_name:Label = $QuizName
@onready var question:Label = $Question
@onready var answers:VBoxContainer = $Answers
@onready var correct_answer:VBoxContainer = $CorrectAnswer
@onready var confirm_button:Button = $ConfirmButton

var data:QuestionData

func populate(title:String, question_data:QuestionData):
	data = question_data
	quiz_name.text = title
	question.text = question_data.question
	for i in data.answers.size():
		answers.get_child(i).text = data.answers[i]
