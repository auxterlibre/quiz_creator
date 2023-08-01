class_name QuizData
extends Resource

var title:String
var questions:Array = []


func save():
	var question_list:Array = []
	for question in questions:
		question_list.append(question.save())
	var save_dict:Dictionary = {
		"title":title,
		"questions":question_list
	}
	return save_dict
