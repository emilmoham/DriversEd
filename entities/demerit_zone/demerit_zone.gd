extends Area2D

signal demerit

func _on_timer_timeout() -> void:
	emit_signal("demerit")

func _on_demerit_zones_area_exited(_area: Area2D) -> void:
	$Timer.stop()

func _on_demerit_zones_area_entered(_area: Area2D) -> void:
	$Timer.start()
