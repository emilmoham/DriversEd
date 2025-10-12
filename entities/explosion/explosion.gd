extends Node2D

func _ready() -> void:
	$AnimationPlayer.play("explosion")

func _on_audio_stream_player_2d_finished() -> void:
	queue_free()
