extends Node3D

@export var sky_height: float = 700.0      
@export var spawn_radius: float = 600.0 
@export var streak_duration: float = 1.0
@export var min_delay: float = 1.5
@export var max_delay: float = 4.0

var star_material: StandardMaterial3D

func _ready() -> void:
	_setup_material()
	_spawn_loop()

func _setup_material() -> void:
	star_material = StandardMaterial3D.new()
	star_material.albedo_color = Color(1.0, 1.0, 1.0)
	star_material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	star_material.emission_enabled = true
	star_material.emission = Color(0.7, 0.95, 1.0)
	star_material.emission_energy_multiplier = 12.0

func _spawn_loop() -> void:
	while true:
		var wait_time = randf_range(min_delay, max_delay)
		await get_tree().create_timer(wait_time).timeout
		_create_shooting_star()

func _create_shooting_star() -> void:
	var star_mesh = BoxMesh.new()
	star_mesh.size = Vector3(8.0, 8.0, 140.0) 
	star_mesh.material = star_material

	var star_instance = MeshInstance3D.new()
	star_instance.mesh = star_mesh
	add_child(star_instance)

	var start_x = randf_range(-spawn_radius, spawn_radius)
	var start_z = randf_range(-spawn_radius, spawn_radius)
	var start_pos = Vector3(start_x, sky_height, start_z)

	var travel_vector = Vector3(
		randf_range(-300.0, -500.0),
		randf_range(-80.0, -150.0),
		randf_range(-150.0, 150.0)
	)
	var target_pos = start_pos + travel_vector

	star_instance.global_position = start_pos
	star_instance.look_at(target_pos, Vector3.UP)

	var tween = create_tween().set_parallel(true)
	tween.tween_property(star_instance, "global_position", target_pos, streak_duration)\
		.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property(star_instance, "scale", Vector3(0.01, 0.01, 0.01), streak_duration)\
		.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)

	await tween.finished
	star_instance.queue_free()
