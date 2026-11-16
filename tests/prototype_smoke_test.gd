extends SceneTree

func _initialize() -> void:
	call_deferred("_run_smoke_test")

func _run_smoke_test() -> void:
	var main_scene: PackedScene = load("res://scenes/main.tscn")
	if main_scene == null:
		_fail("Main scene could not be loaded.")
		return

	var world: Node3D = main_scene.instantiate()
	root.add_child(world)
	await process_frame

	var vehicle := _find_vehicle(world)
	if vehicle == null:
		_fail("Player vehicle was not created by the main scene.")
		return

	if vehicle.global_position.y > 0.0:
		_fail("Vehicle spawn height is above the road reference plane.")
		return

	vehicle.call("set_drive_input", 1.0, 0.0, 0.0, false)
	for _frame in range(45):
		await physics_frame

	var forward_speed: float = vehicle.linear_velocity.dot(-vehicle.global_transform.basis.z)
	if forward_speed < 1.0:
		_fail("Vehicle did not accelerate forward. Speed: %.2f m/s" % forward_speed)
		return

	var speed_before_braking := vehicle.linear_velocity.length()
	vehicle.call("set_drive_input", 0.0, 0.0, 1.0, false)
	for _frame in range(20):
		await physics_frame

	var speed_after_braking := vehicle.linear_velocity.length()
	if speed_after_braking >= speed_before_braking:
		_fail("Brake input did not reduce vehicle speed.")
		return

	print("STREET_RUSH_SMOKE_TEST: PASS | spawn, acceleration, braking")
	quit(0)

func _find_vehicle(node: Node) -> RigidBody3D:
	if node is RigidBody3D and node.name == "PlayerVehicle":
		return node as RigidBody3D
	for child in node.get_children():
		var found := _find_vehicle(child)
		if found != null:
			return found
	return null

func _fail(message: String) -> void:
	push_error("STREET_RUSH_SMOKE_TEST: FAIL | " + message)
	quit(1)
