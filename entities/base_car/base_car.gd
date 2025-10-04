@tool
extends Area2D

@export var tint = Color("#FFFFFF")

func _ready() -> void:
	update_color(tint)
	
func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		update_color(tint)

func update_color(color:Color):
	$ColorRect.color = color
	$ColorRect/ColorRect2.color = color
	$ColorRect/ColorRect3.color = color
	$ColorRect/ColorRect4.color = color
	$ColorRect/ColorRect5.color = color
