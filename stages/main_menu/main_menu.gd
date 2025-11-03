extends Node2D

func _on_take_the_exam_clicked() -> void:
	get_tree().change_scene_to_file("res://stages/exam/exam.tscn")


func _on_instructions_clicked() -> void:
	get_tree().change_scene_to_file("res://stages/instructions/instructions.tscn")
