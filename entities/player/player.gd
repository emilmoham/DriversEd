class_name Player
extends Area2D

var wheel_base

@export var is_parked: bool = false:
	set(parked):
		if parked:
			speed_current = 0
		is_parked = parked

var speed_current: float
var speed_max: float = 400
var acceleration: float = 400

var steer_angle_change_speed = PI/2
var steer_angle_max = PI/6

func _ready() -> void:
	speed_current = 0
	wheel_base = ($FrontWheelLeft.position - $BackWheelLeft.position).x
	
func _physics_process(delta: float) -> void:
	adjust_steering(delta)
	adjust_speed(delta)
	
	var front_wheel = position + wheel_base/2 * Vector2(cos(rotation), sin(rotation))
	var back_wheel  = position - wheel_base/2 * Vector2(cos(rotation), sin(rotation))
	
	back_wheel += speed_current * delta * Vector2(cos(rotation), sin(rotation))
	front_wheel += speed_current * delta * Vector2(cos(rotation + $FrontWheelLeft.rotation), sin(rotation + $FrontWheelLeft.rotation))
	
	position = (front_wheel + back_wheel) / 2
	rotation = atan2(front_wheel.y - back_wheel.y, front_wheel.x - back_wheel.x)

func adjust_steering(delta: float):
	var turn = 0
	if Input.is_action_pressed("steer_left"):
		turn -= steer_angle_change_speed * delta
	if Input.is_action_pressed("steer_right"):
		turn += steer_angle_change_speed * delta
	var tire_rotation = $FrontWheelRight.rotation + turn;
	tire_rotation = clamp(tire_rotation, -steer_angle_max, steer_angle_max)
	$FrontWheelLeft.rotation = tire_rotation
	$FrontWheelRight.rotation = tire_rotation
	
func adjust_speed(delta: float):
	var speed_change = 0
	
	if is_parked: return
	
	if Input.is_action_pressed("accelerate"):
		speed_change += acceleration * delta
	if Input.is_action_pressed("brake"):
		speed_change -= acceleration * delta

	speed_current += speed_change;
	speed_current = clamp(speed_current, -speed_max, speed_max)

func _on_area_entered(area: Area2D) -> void:
	if area.collision_layer == CollisionGlobals.CRASH_LAYER:
		ExplosionManager.new().create_explosion(self.get_parent(), self.position)
		queue_free()

func get_collision_rect() -> Rect2:
	return $CollisionShape2D.get_shape().get_rect()

func get_current_speed() -> float:
	return speed_current
