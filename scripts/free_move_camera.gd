
extends Camera3D

@export var move_speed: float = 5.0
@export var fast_speed: float = 12.0
@export var mouse_sensitivity: float = 0.002
@export var scroll_speed: float = 8.0

var mouse_captured := false


func _ready() -> void:
	make_current()


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			mouse_captured = true
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			global_position -= global_basis.z * scroll_speed

		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			global_position += global_basis.z * scroll_speed

	if event.is_action_pressed("ui_cancel"):
		mouse_captured = false
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

	if event is InputEventMouseMotion and mouse_captured:
		rotate_y(-event.relative.x * mouse_sensitivity)
		rotate_object_local(
			Vector3.RIGHT,
			-event.relative.y * mouse_sensitivity
		)
		rotation.x = clamp(
			rotation.x,
			deg_to_rad(-89.0),
			deg_to_rad(89.0)
		)


func _process(delta: float) -> void:
	var direction := Vector3.ZERO

	if Input.is_key_pressed(KEY_W):
		direction -= global_basis.z
	if Input.is_key_pressed(KEY_S):
		direction += global_basis.z
	if Input.is_key_pressed(KEY_A):
		direction -= global_basis.x
	if Input.is_key_pressed(KEY_D):
		direction += global_basis.x
	if Input.is_key_pressed(KEY_E):
		direction += Vector3.UP
	if Input.is_key_pressed(KEY_Q):
		direction -= Vector3.UP

	if direction.length_squared() > 0.0:
		direction = direction.normalized()

	var speed := fast_speed if Input.is_key_pressed(KEY_SHIFT) else move_speed
	global_position += direction * speed * delta
