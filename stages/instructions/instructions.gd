extends Node2D

var slides: Array = [
	"res://stages/instructions/slides/instructions_01.tscn",
	"res://stages/instructions/slides/instructions_02.tscn",
	"res://stages/instructions/slides/instructions_03.tscn",
	"res://stages/instructions/slides/instructions_04.tscn",
	"res://stages/instructions/slides/instructions_05.tscn",
	"res://stages/instructions/slides/instructions_06.tscn",
	"res://stages/instructions/slides/instructions_07.tscn",
	"res://stages/instructions/slides/instructions_08.tscn",
	"res://stages/instructions/slides/instructions_09.tscn",
	"res://stages/instructions/slides/instructions_10.tscn",
]

var current_slide_id: int;
var current_slide: Node2D

func _ready() -> void:
	current_slide_id = 0;
	current_slide = null;
	load_slide(current_slide_id);

func load_slide(id: int) -> void:
	if id < 0 || id >= slides.size():
		print("Invalid slide selected for loading: %d" % id)
		return
	
	if current_slide != null:
		remove_child(current_slide)
		current_slide.queue_free()
		
	var next_slide: Resource = load(slides[id])
	current_slide = next_slide.instantiate()
	current_slide_id = id;
	add_child(current_slide)
	move_child(current_slide, 0)
	
func _on_menu_button_clicked() -> void:
	get_tree().change_scene_to_file("res://stages/main_menu/main_menu.tscn")


func _on_next_button_clicked() -> void:
	var next_slide: int = current_slide_id + 1
	
	# Return to main menu if we're out of slides
	if next_slide == slides.size():
		get_tree().change_scene_to_file("res://stages/main_menu/main_menu.tscn");
		return
	
	load_slide(next_slide)
