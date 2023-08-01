class_name QuestionCreation
extends Control

signal new_question_created(data:QuestionData)

@onready var question_input:TextEdit = $QuestionInput
@onready var answers:VBoxContainer = $Answers
@onready var correct_answers:VBoxContainer = $CorrectAnswer
@onready var confirm_button:Button = $ConfirmButton
@onready var warning:Label = $Warning

var answer_list:Array
var correct_answer_list:Array
var question_data:QuestionData

func _ready():
	answer_list = answers.get_children()
	correct_answer_list = correct_answers.get_children()
	confirm_button.pressed.connect(_on_confirm_pressed)


func clear():
	warning.text = ""
	question_input.text = ""
	for answer in answer_list:
		answer.text = ""
	for checkbox in correct_answer_list:
		checkbox.get_node("CheckBox").button_pressed = false
	

func is_ready_to_confirm():
	warning.text = ""
	if question_input.text == "":
		warning.text = "Campo da pergunta está vazio"
		return false
	for answer in answer_list:
		if answer.text == "":
			warning.text = "Todas as respostas precisam ser preenchidas"
			return false
	
	var value = false
	for checkbox in correct_answer_list:
			if checkbox.get_node("CheckBox").button_pressed:
				value = true
	if not value:
		warning.text = "A resposta correta precisa estar marcada"
	return value


func _on_confirm_pressed():
	if is_ready_to_confirm():
		var data := QuestionData.new()
		data.question = question_input.text
		var list:Array = []
		for answer in answer_list:
			list.append(answer.text)
		data.answers = list
		var correct_answer:int
		for i in correct_answer_list.size():
			var checkbox:CheckBox = correct_answer_list[i].get_node("CheckBox")
			if checkbox.button_pressed:
				correct_answer = i
		data.correct_answer = correct_answer
		new_question_created.emit(data)
