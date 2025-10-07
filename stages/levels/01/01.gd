extends Node2D

var player_size:Vector2;
#var goal: Area2D

func _ready() -> void:
	player_size = $Player
	#var goal_position = $Goal.position
	#var goal_area: Rect2 = $Goal/CollisionShape2D.get_shape().get_rect()
	#print(goal_position)
	#print(goal_area.size)

func _process(delta: float) -> void:
	if Engine.get_frames_drawn() % 200 == 0:
		print(player_size)
		print(get_player_bounding_points())
		
		
func get_player_bounding_points() -> Array:
	var points = []
	
	var rotation = $Player.get_transform().get_rotation()
	
	
	
	
	return points
	
