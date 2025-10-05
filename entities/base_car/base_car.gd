@tool
extends Area2D

@export var tint = Color("#FFFFFF")

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
	ExplosionManager.new().create_explosion(self.get_parent(), self.position)
	queue_free()
