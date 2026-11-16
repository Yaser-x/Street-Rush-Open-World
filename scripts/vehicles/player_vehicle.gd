extends RigidBody3D
class_name PlayerVehicle

@export var engine_force: float = 10500.0
@export var reverse_force: float = 6200.0
@export var brake_force: float = 14500.0
@export var steering_torque: float = 3000.0
@export var max_speed_kmh: float = 145.0
@export var max_reverse_speed_kmh: float = 35.0
@export var lateral_grip: float = 5.5
@export var aerodynamic_drag: float = 0.35
@export var downforce: float = 3.5

var throttle_input: float = 0.0
var steering_input: float = 0.0
var brake_input: float = 0.0
var handbrake_input: bool = false

func set_drive_input(throttle: float, steering: float, brake: float, handbrake: bool) -> void:
	throttle_input = clampf(throttle, -1.0, 1.0)
	steering_input = clampf(steering, -1.0, 1.0)
	brake_input = clampf(brake, 0.0, 1.0)
	handbrake_input = handbrake

func _physics_process(_delta: float) -> void:
	var forward := -global_transform.basis.z
	var right := global_transform.basis.x
	var up := global_transform.basis.y
	var speed_forward := linear_velocity.dot(forward)
	var max_forward_speed := max_speed_kmh / 3.6
	var max_reverse_speed := max_reverse_speed_kmh / 3.6

	if throttle_input > 0.0 and speed_forward < max_forward_speed:
		var speed_factor := clampf(1.0 - (maxf(speed_forward, 0.0) / max_forward_speed), 0.0, 1.0)
		apply_central_force(forward * engine_force * throttle_input * speed_factor)
	elif throttle_input < 0.0 and speed_forward > -max_reverse_speed:
		var reverse_factor := clampf(1.0 - (maxf(-speed_forward, 0.0) / max_reverse_speed), 0.0, 1.0)
		apply_central_force(-forward * reverse_force * absf(throttle_input) * reverse_factor)

	if brake_input > 0.0 and linear_velocity.length() > 0.15:
		apply_central_force(-linear_velocity.normalized() * brake_force * brake_input)

	if handbrake_input and linear_velocity.length() > 0.2:
		apply_central_force(-linear_velocity.normalized() * brake_force * 0.72)

	var lateral_speed := linear_velocity.dot(right)
	var grip_multiplier := 0.24 if handbrake_input else 1.0
	apply_central_force(-right * lateral_speed * mass * lateral_grip * grip_multiplier)

	var speed := linear_velocity.length()
	if speed > 0.1:
		apply_central_force(-linear_velocity.normalized() * aerodynamic_drag * speed * speed)

	if speed_forward > 1.0:
		apply_central_force(-up * speed_forward * speed_forward * downforce)

	var steering_speed := clampf(absf(speed_forward) / 10.0, 0.0, 1.0)
	var travel_direction := 1.0 if speed_forward >= 0.0 else -1.0
	apply_torque(up * steering_input * steering_torque * steering_speed * travel_direction)

func get_speed_kmh() -> float:
	return linear_velocity.length() * 3.6

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = not get_tree().paused
