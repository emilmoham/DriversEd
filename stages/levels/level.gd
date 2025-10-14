class_name ParkingLevel
extends Node2D

signal add_demerit
signal demerit_zone_entered
signal demerit_zone_exited
signal parked
signal player_dead

@export_multiline var test_description: String = ""

var player: Player = null
var is_player_dead: bool = false

func _ready() -> void:
	player = $Player
	player.is_parked = false

func _on_demerit_zone_demerit() -> void:
	emit_signal("add_demerit")

func _on_parked() -> void:
	player.is_parked = true
	emit_signal("parked")

func _on_demerit_zone_area_entered(_area: Area2D) -> void:
	emit_signal("demerit_zone_entered")

func _on_demerit_zone_area_exited(_area: Area2D) -> void:
	if is_player_dead: return
	emit_signal("demerit_zone_exited")

func _on_player_player_dead() -> void:
	is_player_dead = true
	emit_signal("player_dead")
	player.queue_free()
