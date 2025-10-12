extends Node2D

func _on_demerit_zone_demerit() -> void:
	$ExamUI.add_demerit()


func _on_parked() -> void:
	$Player.is_parked = true


func _on_demerit_zone_area_entered(_area: Area2D) -> void:
	$ExamUI.set_instructor_state(InstructorGlobals.InstructorAnimation.ANGRY)


func _on_demerit_zone_area_exited(_area: Area2D) -> void:
	$ExamUI.set_instructor_state(InstructorGlobals.InstructorAnimation.CALM)
