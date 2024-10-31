class_name LerpSmoothingTargetFocus
extends CameraControllerBase

@export var lead_speed: float = target.BASE_SPEED*2
@export var catchup_delay_duration: float = 10.0
@export var catchup_speed: float = target.BASE_SPEED/2
@export var leash_distance: float = 100.0

var delay_count:float = 0.0

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
	

	# Normalize the direction from the camera to the target
	var direction_to_target = (target_position - global_position).normalized()
	
	# Make the camera view the target from above
	rotation_degrees = Vector3(-90, 0, 0)
	
	# Camera will travel in front of target whichever direction is pressed
	if Input.is_action_pressed("ui_left"):
		global_translate(-transform.basis.x * lead_speed * delta + direction_to_target * lead_speed * delta)
	if Input.is_action_pressed("ui_right"):
		global_translate(transform.basis.x * lead_speed * delta + direction_to_target * lead_speed * delta)
	if Input.is_action_pressed("ui_up"):
		global_translate(transform.basis.z * lead_speed * delta + direction_to_target * lead_speed * delta)		
	if Input.is_action_pressed("ui_down"):
		global_translate(-transform.basis.z * lead_speed * delta + direction_to_target * lead_speed * delta)
	else:
		delay_count += 1.0
	
	# Camera will keep up with target speed
	if Input.is_action_pressed("ui_accept"):
		lead_speed = target.HYPER_SPEED*2
	else:
		lead_speed = target.BASE_SPEED*2
		
	# Keep leash on target
	if dist_to_target > leash_distance and catchup_delay_duration != delay_count:
		global_position = target_position - direction_to_target * leash_distance
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
	
	
