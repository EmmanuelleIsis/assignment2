extends Area3D

@export var outdoor_player: AudioStreamPlayer
@export var indoor_player: AudioStreamPlayer

@onready var collision_shape: CollisionShape3D = $CollisionShape3D

var was_inside: bool = false

func _ready() -> void:
	if outdoor_player and not outdoor_player.playing:
		outdoor_player.play()
	if indoor_player and indoor_player.playing:
		indoor_player.stop()

func _process(_delta: float) -> void:
	var camera = get_viewport().get_camera_3d()
	if not camera or not collision_shape or not collision_shape.shape is BoxShape3D:
		return
	
	var box = collision_shape.shape as BoxShape3D
	var local_pos = collision_shape.global_transform.affine_inverse() * camera.global_position
	var extents = box.size * 0.5
	
	var is_inside = abs(local_pos.x) <= extents.x and abs(local_pos.y) <= extents.y and abs(local_pos.z) <= extents.z
	
	if is_inside != was_inside:
		was_inside = is_inside
		if is_inside:
			print("Camera entered cabin bounds.")
			if outdoor_player:
				outdoor_player.volume_db = -20.0
			if indoor_player and not indoor_player.playing:
				indoor_player.play()
		else:
			print("Camera left cabin bounds.")
			if outdoor_player:
				outdoor_player.volume_db = 0.0
			if indoor_player:
				indoor_player.stop()
