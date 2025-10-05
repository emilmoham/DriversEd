extends Node2D

func _ready() -> void:
	$AnimationPlayer.play("explosion")

func _on_animation__finished(_anim_name: StringName) -> void:
	queue_free()
