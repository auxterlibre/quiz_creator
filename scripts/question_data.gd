class_name QuestionData
extends Resource

var question:String
var answers:Array = []
var correct_answer:int


func save():
	var dict:Dictionary = {
		"question":question,
		"answers":answers,
		"correct_answer":correct_answer
		}
	return dict
