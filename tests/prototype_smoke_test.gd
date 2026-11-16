extends Node

func _ready() -> void:
	call_deferred("_run_smoke_test")

func _run_smoke_test() -> void:
	var main_scene: PackedScene = load("res://scenes/main.tscn")
	if main_scene == null:
		_fail("Main scene could not be loaded.")
		return
	var world: Node3D = main_scene.instantiate()
	add_child(world)
	await get_tree().process_frame
	var vehicle := _find_vehicle(world)
	if vehicle == null:
		_fail("Player vehicle was not created by the main scene.")
		return
	var hud := _find_hud(world)
	if hud == null:
		_fail("Mobile HUD was not created by the main scene.")
		return
	if not vehicle.is_physics_processing():
		_fail("Vehicle physics processing is disabled.")
		return
	if vehicle.global_position.y > 0.0:
		_fail("Vehicle spawn height is above the road reference plane.")
		return
	hud.call("_set_control", "accelerate", true)
	await get_tree().process_frame
	if not is_equal_approx(float(vehicle.get("throttle_input")), 1.0):
		_fail("HUD accelerator value did not reach the vehicle controller.")
		return
	for _frame in range(45):
		await get_tree().physics_frame
	var forward_speed: float = vehicle.linear_velocity.dot(-vehicle.global_transform.basis.z)
	print("SMOKE_DIAGNOSTIC | position=", vehicle.global_position, " velocity=", vehicle.linear_velocity, " throttle=", vehicle.get("throttle_input"))
	if forward_speed < 1.0:
		_fail("Vehicle did not accelerate from HUD input. Speed: %.2f m/s" % forward_speed)
		return
	var speed_before_braking := vehicle.linear_velocity.length()
	hud.call("_set_control", "accelerate", false)
	hud.call("_set_control", "brake", true)
	await get_tree().process_frame
	for _frame in range(20):
		await get_tree().physics_frame
	var speed_after_braking := vehicle.linear_velocity.length()
	if speed_after_braking >= speed_before_braking:
		_fail("HUD brake input did not reduce vehicle speed.")
		return
	print("STREET_RUSH_SMOKE_TEST: PASS | scene, spawn, HUD acceleration, HUD braking")
	get_tree().quit(0)

func _find_vehicle(node: Node) -> RigidBody3D:
	if node is RigidBody3D and node.name == "PlayerVehicle":
		return node as RigidBody3D
	for child in node.get_children():
		var found := _find_vehicle(child)
		if found != null:
			return found
	return null

func _find_hud(node: Node) -> CanvasLayer:
	if node is CanvasLayer and node.has_method("_set_control"):
		return node as CanvasLayer
	for child in node.get_children():
		var found := _find_hud(child)
		if found != null:
			return found
	return null

func _fail(message: String) -> void:
	push_error("STREET_RUSH_SMOKE_TEST: FAIL | " + message)
	get_tree().quit(1)
