@tool
extends Area2D

signal parked

@export var player: Player
@export var goal_speed_threshold: float = 10
@export var collision_shape: CollisionShape2D
@export var debug_area_color: Color = Color(0, 1, 0, 0.3)

var check_if_player_in_area: bool
var player_radius: float
var player_phi: float
var goal_bounds: Dictionary
var is_parked: bool = false:
	set(new_is_parked):
		if is_parked != new_is_parked && new_is_parked:
			emit_signal("parked")
			set_parking_zone_visibility(true)
			check_if_player_in_area = false
		is_parked = new_is_parked

func _ready() -> void:
	check_if_player_in_area = false
	set_parking_zone_visibility(false)
	
	if player == null: return
	if collision_shape == null: return
	
	update_zone_visual()
	
	var player_collision_size = player.get_collision_rect().size * player.get_transform().get_scale()
	var player_width = player_collision_size.x
	var player_height = player_collision_size.y
	player_radius = sqrt(player_width * player_width + player_height * player_height)/2
	player_phi = atan2(player_height, player_width)
	
	var goal_position = collision_shape.global_position
	var goal_size = collision_shape.get_shape().get_rect().size / 2
	
	goal_bounds = {
		"left": goal_position.x - goal_size.x,
		"right": goal_position.x + goal_size.x,
		"top": goal_position.y  + goal_size.y,
		"bottom": goal_position.y - goal_size.y
	}

func _process(_delta: float) -> void:	
	if Engine.is_editor_hint() && collision_shape:
		collision_shape.position = Vector2.ZERO
		update_zone_visual()
		
	if check_if_player_in_area:
		is_parked = is_in_goal(get_player_bounding_points()) \
					&& player.get_current_speed() < goal_speed_threshold

func _on_area_entered(area: Area2D) -> void:
	if area == player:
		check_if_player_in_area = true

func _on_area_exited(area: Area2D) -> void:
	if area == player:
		check_if_player_in_area = false
		set_parking_zone_visibility(false)

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

	return point.x >= goal_bounds["left"]   \
		&& point.x <= goal_bounds["right"]  \
		&& point.y >= goal_bounds["bottom"] \
		&& point.y <= goal_bounds["top"] 
	
func is_in_goal(player_points: Array) -> bool:
	return player_points.all(point_is_in_goal)

func update_zone_visual() -> void:
	if collision_shape == null: return
	var area_size = collision_shape.get_shape().get_rect().size
	$ColorRect.size = area_size
	$ColorRect.position = Vector2.ZERO - area_size/2

func set_parking_zone_visibility(zone_visible: bool) -> void:
	$ColorRect.visible = zone_visible
