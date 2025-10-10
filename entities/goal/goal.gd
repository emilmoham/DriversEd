extends Area2D

@export var player: Area2D

var check_if_player_in_area: bool
var player_radius: float
var player_phi: float
var goal_bounds: Dictionary

func _ready() -> void:
	check_if_player_in_area = false
	
	if player == null: return 
	
	var player_collision_size = player.get_collision_rect().size * player.get_transform().get_scale()
	var player_width = player_collision_size.x
	var player_height = player_collision_size.y
	player_radius = sqrt(player_width * player_width + player_height * player_height)/2
	player_phi = atan2(player_height, player_width)
	
	var goal_position = $CollisionShape2D.global_position
	var goal_size = $CollisionShape2D.get_shape().get_rect().size * global_scale / 2
	goal_bounds = {
		"left": goal_position.x - goal_size.x,
		"right": goal_position.x + goal_size.x,
		"top": goal_position.y  + goal_size.y,
		"bottom": goal_position.y - goal_size.y
	}

func _process(_delta: float) -> void:
	if check_if_player_in_area:
		if is_in_goal(get_player_bounding_points()):
			player.queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area == player:
		check_if_player_in_area = true

func _on_area_exited(area: Area2D) -> void:
	if area == player:
		check_if_player_in_area = false

func get_player_bounding_points() -> Array:
	if player == null: return []
	var current_position = player.global_position
	var current_rotation = player.global_rotation
	
	# Assume rectangle R has the points:
	#  b ------------ a
	#  |              |
	#  |      o       |
	#  |              |
	#  c--------------d
	# 
	var a = Vector2(player_radius * cos(current_rotation + player_phi), player_radius * sin(current_rotation + player_phi))
	var d = Vector2(player_radius * cos(current_rotation - player_phi), player_radius * sin(current_rotation - player_phi))
	 
	return [
		a
		-d,
		-a,
		d
	].map(func addPosition(elem): return elem + current_position)

func point_is_in_goal(point: Vector2) -> bool:

	return point.x >= goal_bounds["left"] \
		&& point.x <= goal_bounds["right"] \
		&& point.y >= goal_bounds["bottom"] \
		&& point.y <= goal_bounds["top"] 
	
func is_in_goal(player_points: Array) -> bool:
	return player_points.all(point_is_in_goal)
