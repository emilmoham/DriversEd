extends Node2D

func _on_timer_timeout() -> void:
	print("demerit")

func _on_demerit_zones_area_exited(area: Area2D) -> void:
	$DemeritZones/Timer.stop()

func _on_demerit_zones_area_entered(area: Area2D) -> void:
	$DemeritZones/Timer.start()
