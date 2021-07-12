extends Node2D

var data = {}
var file_name = ""
var row = 0
var speed = 0
var speak_text = ""
var speak_bubble = ""
var speak_label = ""
var speak_bubble_other
var turn = 0
var bubble_variant = ""



func _ready():
	file_name = "res://comic1-en.txt"
	
	var file = File.new()
	if file.file_exists(file_name):
		var error = file.open(file_name, File.READ)
		if error == OK:
			data = str2var(file.get_as_text())
			file.close()
			
	speed = float(data.speed)
	$Progress.max_value = data.comic.size()
	start()



func start():
	$Bubble1.visible = false
	$Bubble1b.visible = false
	$Label1.visible = false
	$Label1b.visible = false
	$Char1.visible = false
	
	$Bubble2.visible = false
	$Bubble2b.visible = false
	$Label2.visible = false
	$Label2b.visible = false
	$Char2.visible = false
	
	$GoLeft.visible = false
	$GoRight.visible = false
	
	$Progress.value = row + 1
	$Background.texture = load("res://images/" + data.comic[row][0] + ".jpg")
	
	if data.comic[row][1] != "":
		$Char1.texture = load("res://images/" + data.comic[row][1] + ".png")
		$Char1.visible = true
	else:
		$Char1.visible = false
	
	if data.comic[row][2] != "":
		$Char2.texture = load("res://images/" + data.comic[row][2] + ".png")
		$Char2.visible = true
	else:
		$Char2.visible = false
	
	
	if data.comic[row][3].begins_with("1"):			# 1 = Who speaks first?
		turn = 1
		speak_left()
	elif data.comic[row][3].begins_with("2"):
		turn = 1
		speak_right()



func speak_left():
	speak_text = data.comic[row][4]
	speak_bubble = "Bubble1"
	speak_label = "Label1"
	speak_bubble_other = "Bubble2"
	speak()



func speak_right():
	speak_text = data.comic[row][5]
	speak_bubble = "Bubble2"
	speak_label = "Label2"
	speak_bubble_other = "Bubble1"
	speak()



func speak():
	yield(get_tree().create_timer(speed), "timeout")
		
	if speak_text.length() < 30:						# fits on one line
		get_node(speak_bubble).scale.y = .14
		get_node(speak_bubble).position.y = 47
		get_node(speak_label).rect_position.y = 19
	elif speak_text.length() < 60:						# 2 lines
		get_node(speak_bubble).scale.y = .19
		get_node(speak_bubble).position.y = 45
		get_node(speak_label).rect_position.y = 15
	elif speak_text.length() > 80:						# 4 lines
		get_node(speak_bubble).scale.y = .32
		get_node(speak_bubble).position.y = 47
		get_node(speak_label).rect_position.y = 12
	else:												# else: 3 lines
		get_node(speak_bubble).scale.y = .24
		get_node(speak_bubble).position.y = 46
		get_node(speak_label).rect_position.y = 14
	
	if speak_text.begins_with("%"):
		bubble_variant = speak_text[1]
		if bubble_variant == "b":
			speak_bubble += "b"
			speak_label += "b"
			get_node(speak_bubble).scale.y = .3
		speak_text.erase(0, 2)
	else:
		bubble_variant = ""
	
	get_node(speak_bubble).modulate.a = 0
	get_node(speak_bubble).visible = true
	get_node(speak_bubble + "/Tween").interpolate_property(get_node(speak_bubble), "modulate:a", 0, 1, .5, Tween.TRANS_SINE, Tween.EASE_IN)
	get_node(speak_bubble + "/Tween").start()
	
	yield(get_tree().create_timer(speed), "timeout")
	get_node(speak_label).text = speak_text
	get_node(speak_label).visible = true
	
	if data.comic[row][3].ends_with("2") and turn == 1:
		turn = 2
		speak_right()
	elif data.comic[row][3].ends_with("1") and turn == 1:
		turn = 2
		speak_left()	
	else:
		yield(get_tree().create_timer(speed), "timeout")
		buttons()



func _on_GoRight_pressed():
	row += 1
	start()


func _on_GoLeft_pressed():
	row -= 1
	start()


func buttons():
	if row == 0:
		$GoLeft.visible = false
	else:
		$GoLeft.visible = true
	if row + 1 == data.comic.size():
		$GoRight.visible = false
	else:
		$GoRight.visible = true
