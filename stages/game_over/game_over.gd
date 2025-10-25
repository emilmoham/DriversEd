extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$GameOverAudio.play()


func _on_game_over_audio_finished() -> void:
	get_tree().change_scene_to_file("res://stages/main_menu/main_menu.tscn")
