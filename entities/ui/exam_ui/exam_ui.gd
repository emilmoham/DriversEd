class_name ExamUI
extends Node2D

@export var test_number: int = 0
@export_multiline var test_description: String = "Description Here"
var demerits: int = 0

func _ready() -> void:
	$TestNumberLabel.text = "Test #%d:" % test_number
	$TestDescriptionLabel.text = test_description
	$DemeritsCountLabel.text = str(demerits)
	
func _process(_delta: float) -> void:
	$DemeritsCountLabel.text = str(demerits)

func set_instructor_state(instructor_animation: InstructorGlobals.InstructorAnimation) -> void:
	$InstructorExam.play_anmiation(instructor_animation)

func add_demerit() -> void:
	demerits += 1
