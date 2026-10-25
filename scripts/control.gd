extends Control

@onready var FPS_label = $CanvasLayer/MarginContainer/VBoxContainer/Label
@onready var Primitive_label = $CanvasLayer/MarginContainer/VBoxContainer/Label2
@onready var DrawCalls_label = $CanvasLayer/MarginContainer/VBoxContainer/Label3
@onready var Collisions_label = $CanvasLayer/MarginContainer/VBoxContainer/Label4
@onready var NodeCount_label = $CanvasLayer/MarginContainer/VBoxContainer/Label5
@onready var ObjectsInFrame_label = $CanvasLayer/MarginContainer/VBoxContainer/Label6
@onready var ActiveObjects_label = $CanvasLayer/MarginContainer/VBoxContainer/Label7

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	FPS_label.text = "FPS:" + str(Engine.get_frames_per_second())
	
	Primitive_label.text = "Primitive count: " + str(Performance.get_monitor(Performance.RENDER_TOTAL_PRIMITIVES_IN_FRAME))
	
	DrawCalls_label.text = "Draw calls: " + str(Performance.get_monitor(Performance.RENDER_TOTAL_DRAW_CALLS_IN_FRAME))

	Collisions_label.text = "Collision pairs: " + str(Performance.get_monitor(Performance.PHYSICS_3D_COLLISION_PAIRS))
	
	NodeCount_label.text = "Node count: " + str(Performance.get_monitor(Performance.OBJECT_NODE_COUNT))
	
	ObjectsInFrame_label.text = "Objects in frame: " + str(Performance.get_monitor(Performance.RENDER_TOTAL_OBJECTS_IN_FRAME))
	
	ActiveObjects_label.text = "Active Objects in frame: " + str(Performance.get_monitor(Performance.PHYSICS_3D_ACTIVE_OBJECTS))
	
