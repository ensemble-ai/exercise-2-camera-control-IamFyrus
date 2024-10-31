class_name LerpSmoothingTargetFocus
extends CameraControllerBase

@export var lead_speed: float = 75.0
@export var catchup_delay_duration: float = 2.0
@export var catchup_speed: float = 10.0
@export var leash_distance: float = 40.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	position = target.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if !current:
		return
	
	var height = 10
	var dist_to_target = global_position.distance_to(target.global_position)
	var target_position = Vector3(target.global_position.x, target.global_position.y + height, target.global_position.z)
	
	# Make the camera view the target from above
	rotation_degrees = Vector3(-90, 0, 0)
	
	if dist_to_target > leash_distance:
		global_position = global_position.lerp(target_position, lead_speed * delta)
	else:
		global_position = global_position.lerp(target_position, catchup_speed * delta)
	
	if draw_camera_logic:
		draw_logic()	

	super(delta)
	
func draw_logic():
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	# Find size of each side of cross
	var total_size:float = 5
	var side:float = total_size/2
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	
	# Set horizontal lines of cross
	immediate_mesh.surface_add_vertex(Vector3(side, 0, 0))
	immediate_mesh.surface_add_vertex(Vector3(-side, 0, 0))
	
	# Set vertical lines of cross
	immediate_mesh.surface_add_vertex(Vector3(0, 0, side))
	immediate_mesh.surface_add_vertex(Vector3(0, 0, -side))
	
	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
	
	
