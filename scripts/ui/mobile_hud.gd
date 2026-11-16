extends CanvasLayer
class_name MobileHUD

var vehicle: PlayerVehicle
var throttle_value: float = 0.0
var steering_value: float = 0.0
var brake_value: float = 0.0
var handbrake_value: bool = false
var speed_label: Label

func bind_vehicle(target: PlayerVehicle) -> void:
	vehicle = target
	_build_ui()

func _process(_delta: float) -> void:
	if not is_instance_valid(vehicle):
		return
	var speed := int(round(vehicle.get_speed_kmh()))
	speed_label.text = "%03d KM/H" % speed
	var keyboard_throttle := Input.get_action_strength("accelerate") - Input.get_action_strength("reverse")
	var keyboard_steering := Input.get_action_strength("steer_right") - Input.get_action_strength("steer_left")
	var keyboard_brake := 1.0 if Input.is_action_pressed("handbrake") else 0.0
	var throttle := throttle_value if not is_zero_approx(throttle_value) else keyboard_throttle
	var steering := steering_value if not is_zero_approx(steering_value) else keyboard_steering
	var brake := maxf(brake_value, keyboard_brake)
	vehicle.set_drive_input(throttle, steering, brake, handbrake_value or Input.is_action_pressed("handbrake"))

func _build_ui() -> void:
	speed_label = Label.new()
	speed_label.text = "000 KM/H"
	speed_label.position = Vector2(28, 24)
	speed_label.add_theme_font_size_override("font_size", 30)
	speed_label.add_theme_color_override("font_color", Color(0.95, 0.91, 0.78))
	add_child(speed_label)

	var title := Label.new()
	title.text = "STREET RUSH  /  COASTAL TEST DISTRICT"
	title.position = Vector2(30, 62)
	title.add_theme_font_size_override("font_size", 13)
	title.add_theme_color_override("font_color", Color(0.72, 0.82, 0.86))
	add_child(title)

	var pause := _make_button("Ⅱ", Vector2(92, 58), Vector2(1.0, 0.0), Vector2(-112, 18), Vector2(-20, 76))
	pause.pressed.connect(_toggle_pause)

	_make_hold_button("◀", "steer_left", Vector2(0.0, 1.0), Vector2(24, -116), Vector2(96, -34))
	_make_hold_button("▶", "steer_right", Vector2(0.0, 1.0), Vector2(104, -116), Vector2(176, -34))
	_make_hold_button("BRAKE", "brake", Vector2(1.0, 1.0), Vector2(-252, -108), Vector2(-164, -28))
	_make_hold_button("GAS", "accelerate", Vector2(1.0, 1.0), Vector2(-148, -132), Vector2(-48, -28))
	_make_hold_button("DRIFT", "handbrake", Vector2(1.0, 1.0), Vector2(-360, -86), Vector2(-264, -28))

func _make_hold_button(caption: String, control: String, anchor: Vector2, offset_min: Vector2, offset_max: Vector2) -> void:
	var button := _make_button(caption, offset_max - offset_min, anchor, offset_min, offset_max)
	button.button_down.connect(func() -> void: _set_control(control, true))
	button.button_up.connect(func() -> void: _set_control(control, false))

func _make_button(caption: String, _size: Vector2, anchor: Vector2, offset_min: Vector2, offset_max: Vector2) -> Button:
	var button := Button.new()
	button.text = caption
	button.anchor_left = anchor.x
	button.anchor_right = anchor.x
	button.anchor_top = anchor.y
	button.anchor_bottom = anchor.y
	button.offset_left = offset_min.x
	button.offset_top = offset_min.y
	button.offset_right = offset_max.x
	button.offset_bottom = offset_max.y
	button.add_theme_font_size_override("font_size", 18)
	button.modulate = Color(0.88, 0.94, 1.0, 0.88)
	add_child(button)
	return button

func _set_control(control: String, pressed: bool) -> void:
	match control:
		"accelerate":
			throttle_value = 1.0 if pressed else 0.0
		"reverse":
			throttle_value = -1.0 if pressed else 0.0
		"steer_left":
			steering_value = -1.0 if pressed else 0.0
		"steer_right":
			steering_value = 1.0 if pressed else 0.0
		"brake":
			brake_value = 1.0 if pressed else 0.0
		"handbrake":
			handbrake_value = pressed

func _toggle_pause() -> void:
	get_tree().paused = not get_tree().paused
	if get_tree().paused:
		process_mode = Node.PROCESS_MODE_ALWAYS
