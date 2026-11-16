extends Node3D

const VEHICLE_SCENE: PackedScene = preload("res://scenes/player_vehicle.tscn")
const HUD_SCRIPT = preload("res://scripts/ui/mobile_hud.gd")

func _ready() -> void:
	_build_environment()
	_build_test_district()
	var vehicle: PlayerVehicle = VEHICLE_SCENE.instantiate()
	add_child(vehicle)
	vehicle.global_position = Vector3(0.0, 0.18, 18.0)
	var hud := CanvasLayer.new()
	hud.set_script(HUD_SCRIPT)
	add_child(hud)
	hud.bind_vehicle(vehicle)

func _build_environment() -> void:
	var world_environment := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_SKY
	var sky := Sky.new()
	sky.sky_material = ProceduralSkyMaterial.new()
	environment.sky = sky
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_SKY
	environment.tonemap_mode = Environment.TONE_MAPPER_FILMIC
	world_environment.environment = environment
	add_child(world_environment)

	var sun := DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-48.0, -28.0, 0.0)
	sun.light_energy = 1.15
	sun.shadow_enabled = true
	add_child(sun)

func _build_test_district() -> void:
	_add_static_box("Ground", Vector3(0, -0.6, 0), Vector3(180, 1, 180), Color(0.16, 0.28, 0.20))
	_add_static_box("MainRoad", Vector3(0, -0.04, 0), Vector3(18, 0.18, 140), Color(0.105, 0.12, 0.14))
	_add_static_box("CrossRoad", Vector3(0, -0.035, -28), Vector3(110, 0.19, 14), Color(0.105, 0.12, 0.14))
	_add_static_box("SideRoad", Vector3(0, -0.035, 34), Vector3(80, 0.19, 12), Color(0.105, 0.12, 0.14))

	for z in range(-62, 64, 8):
		_add_visual_box("LaneDash", Vector3(0, 0.065, float(z)), Vector3(0.18, 0.025, 3.4), Color(0.92, 0.84, 0.58))

	var building_specs: Array[Dictionary] = [
		{"p": Vector3(-17, 3, -18), "s": Vector3(12, 6, 15), "c": Color(0.48, 0.43, 0.36)},
		{"p": Vector3(18, 5, -18), "s": Vector3(13, 10, 15), "c": Color(0.32, 0.43, 0.52)},
		{"p": Vector3(-18, 4, 20), "s": Vector3(13, 8, 16), "c": Color(0.58, 0.48, 0.36)},
		{"p": Vector3(19, 3, 20), "s": Vector3(14, 6, 16), "c": Color(0.40, 0.48, 0.42)},
		{"p": Vector3(-35, 6, -42), "s": Vector3(16, 12, 18), "c": Color(0.38, 0.43, 0.50)},
		{"p": Vector3(36, 7, -43), "s": Vector3(17, 14, 18), "c": Color(0.52, 0.45, 0.38)}
	]
	for spec in building_specs:
		_add_static_box("BlockoutBuilding", spec["p"], spec["s"], spec["c"])

	_add_visual_box("CoastalWater", Vector3(0, -0.35, -82), Vector3(180, 0.25, 28), Color(0.06, 0.30, 0.43))

func _add_static_box(node_name: String, position: Vector3, size: Vector3, color: Color) -> void:
	var body := StaticBody3D.new()
	body.name = node_name
	body.position = position
	var collision := CollisionShape3D.new()
	var shape := BoxShape3D.new()
	shape.size = size
	collision.shape = shape
	body.add_child(collision)
	var mesh_instance := MeshInstance3D.new()
	var mesh := BoxMesh.new()
	mesh.size = size
	mesh_instance.mesh = mesh
	mesh_instance.material_override = _make_material(color)
	body.add_child(mesh_instance)
	add_child(body)

func _add_visual_box(node_name: String, position: Vector3, size: Vector3, color: Color) -> void:
	var mesh_instance := MeshInstance3D.new()
	mesh_instance.name = node_name
	mesh_instance.position = position
	var mesh := BoxMesh.new()
	mesh.size = size
	mesh_instance.mesh = mesh
	mesh_instance.material_override = _make_material(color)
	add_child(mesh_instance)

func _make_material(color: Color) -> StandardMaterial3D:
	var material := StandardMaterial3D.new()
	material.albedo_color = color
	material.roughness = 0.88
	return material
