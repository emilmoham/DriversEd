@tool
extends Area2D

@export var tint = Color("#FFFFFF")

const Explosion = preload("res://entities/explosion/explosion.tscn")

func _ready() -> void:
	update_color(tint)
	
func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		update_color(tint)

func update_color(color:Color):
	$CarNode/ColorRect.color = color
	$CarNode/ColorRect/ColorRect2.color = color
	$CarNode/ColorRect/ColorRect3.color = color
	$CarNode/ColorRect/ColorRect4.color = color
	$CarNode/ColorRect/ColorRect5.color = color


func _on_area_entered(area: Area2D) -> void:
	$CollisionShape2D.set_deferred("disabled", true)
	
	$CarNode.visible = false
	var rotation = self.get_transform().get_rotation()
	
	var explosion_instance = Explosion.instantiate() as Node2D
	explosion_instance.rotation += -1 * rotation
	self.add_child(explosion_instance)
