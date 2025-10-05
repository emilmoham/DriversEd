class_name ExplosionManager extends RefCounted

const Explosion = preload("res://entities/explosion/explosion.tscn")

func create_explosion(scene: Node, position: Vector2) -> void:
	var explosion_instance = Explosion.instantiate() as Node2D
	explosion_instance.position = position
	scene.add_child(explosion_instance)
