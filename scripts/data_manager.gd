extends Node


func save_quiz(quiz_data:QuizData):
	var path:String = quiz_data.title
	path.replace(" ", "_")
	var file = FileAccess.open("user://" + path + ".quiz", FileAccess.WRITE)
	var data = quiz_data.save()
	file.store_line(JSON.stringify(data))
	file.close()
	print("QUIZ SAVED - ", path)


func load_quiz(file_path):
	if not FileAccess.file_exists(file_path):
		print("No file found")
		return

	var file = FileAccess.open(file_path, FileAccess.READ)
	var quiz_data := QuizData.new()
	while file.get_position() < file.get_length():
		var test_json_conv = JSON.new()
		test_json_conv.parse(file.get_line())
		var node_data = test_json_conv.get_data()
		quiz_data.title = node_data["title"]
		var questions:Array = []
		for i in node_data["questions"]:
			var question_data := QuestionData.new()
			question_data.question = i["question"]
			question_data.answers = i["answers"]
			question_data.correct_answer = i["correct_answer"]
			questions.append(question_data)
		quiz_data.questions = questions
	file.close()
	return quiz_data

