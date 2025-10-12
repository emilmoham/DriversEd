extends AnimatedSprite2D

func play_anmiation(desired_animation: InstructorGlobals.InstructorAnimation) -> void:
	$AudioStreamPlayer2D.stop()
	
	match desired_animation:
		InstructorGlobals.InstructorAnimation.CALM:
			animation = "calm"
		InstructorGlobals.InstructorAnimation.ANGRY:
			animation = "angry"
			$AudioStreamPlayer2D.play()
	
	play()
