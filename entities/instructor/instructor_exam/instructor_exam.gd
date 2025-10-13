extends AnimatedSprite2D

func play_anmiation(desired_animation: InstructorGlobals.InstructorAnimation) -> void:
	$DemeritBabbleSound.stop()
	
	match desired_animation:
		InstructorGlobals.InstructorAnimation.CALM:
			animation = "calm"
		InstructorGlobals.InstructorAnimation.ANGRY:
			animation = "angry"
			$DemeritBabbleSound.play()
		InstructorGlobals.InstructorAnimation.EXPLODED:
			ExplosionManager.new().create_explosion(self.get_parent(), self.position)
			animation = "exploded"
	
	play()
