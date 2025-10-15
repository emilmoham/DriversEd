extends Node2D

@export var current_level_number: int

var levels: Array = [
	null,
	"res://stages/levels/01.tscn",
	"res://stages/levels/02.tscn",
	"res://stages/levels/03.tscn",
	"res://stages/levels/04.tscn",
	"res://stages/levels/05.tscn",
	"res://stages/levels/06.tscn",
	"res://stages/levels/07.tscn"
]

var ui: ExamUI = null
var level_change_timer: Timer = null
var current_level: ParkingLevel = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ui = $UI
	ui.set_instructor_state(InstructorGlobals.InstructorAnimation.CALM)
	
	level_change_timer = $LevelChangeTimer
	
	load_level(current_level_number)

func _on_add_demerit() -> void:
	ui.add_demerit()

func _on_demerit_zone_entered() -> void:
	ui.set_instructor_state(InstructorGlobals.InstructorAnimation.ANGRY)

func _on_demerit_zone_exited() -> void:
	ui.set_instructor_state(InstructorGlobals.InstructorAnimation.CALM)

func _on_parked() -> void:
	level_change_timer.start()
	await level_change_timer.timeout
	if current_level_number < levels.size() - 1:
		current_level_number += 1
		load_level(current_level_number)
	else:
		print("you win :)")

func _on_player_dead() -> void:
	ui.set_instructor_state(InstructorGlobals.InstructorAnimation.EXPLODED)
	# wait a few seconds
	print("show game over")

func load_level(id: int) -> void:
	if id < 1 || id > levels.size():
		print("Invalid level selected for loading: %d" % current_level_number)
		return
	
	if current_level != null:
		remove_child(current_level)
		current_level.queue_free()
	
	var next_level: Resource = load(levels[id])
	current_level = next_level.instantiate()
	current_level.connect("add_demerit", _on_add_demerit)
	current_level.connect("demerit_zone_entered", _on_demerit_zone_entered)
	current_level.connect("demerit_zone_exited", _on_demerit_zone_exited)
	current_level.connect("parked", _on_parked)
	current_level.connect("player_dead", _on_player_dead)
	
	ui.test_number = id
	ui.test_description = current_level.test_description
	ui.queue_redraw()
	
	add_child(current_level)
	move_child(current_level, 0)
