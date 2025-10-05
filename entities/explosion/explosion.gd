extends Node2D

func _ready() -> void:
	$AnimationPlayer.play("explosion")



func _on_animation__finished(anim_name: StringName) -> void:
	if (anim_name == "explosion"):
		queue_free()
