@tool
extends Area2D

@export var tint = Color("#FFFFFF")

const Explosion = preload("res://entities/explosion/explosion.tscn")

func _ready() -> void:
	update_color(tint)
	
func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		update_color(tint)

func update_color(color:Color):
	$CarNode/ColorRect.color = color
	$CarNode/ColorRect/ColorRect2.color = color
	$CarNode/ColorRect/ColorRect3.color = color
	$CarNode/ColorRect/ColorRect4.color = color
	$CarNode/ColorRect/ColorRect5.color = color


func _on_area_entered(_area: Area2D) -> void:
	$CollisionShape2D.set_deferred("disabled", true)
	
	$CarNode.visible = false
	var parent_rotation = self.get_transform().get_rotation()
	var parent_position = self.get_transform().get_origin()
	
	var explosion_instance = Explosion.instantiate() as Node2D
	explosion_instance.position = parent_position
	get_parent().add_child(explosion_instance)
	queue_free()
