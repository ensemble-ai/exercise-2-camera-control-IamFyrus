class_name SpeedupPushZone
extends CameraControllerBase

# This does not work

@export var push_ratio: float = 2.0
@export var pushbox_top_left: Vector2 = Vector2(-5.0, 5.0)  
@export var pushbox_bottom_right: Vector2 = Vector2(5.0, -5.0) 
@export var speedup_zone_top_left: Vector2 = Vector2(-3.0, 3.0) 
@export var speedup_zone_bottom_right: Vector2 = Vector2(3.0, -3.0) 

var box_width: float
var box_height: float

func _ready() -> void:
	super()
	position = target.position
	box_width = pushbox_bottom_right.x - pushbox_top_left.x
	box_height = pushbox_top_left.y - pushbox_bottom_right.y

func _process(delta: float) -> void:
	if !current:
		return

	var height = 10
	var dist_to_target = global_position.distance_to(target.global_position)
	var target_position = Vector3(target.global_position.x, target.global_position.y + height, target.global_position.z)
	
	# Make the camera view the target from above
	rotation_degrees = Vector3(-90, 0, 0)
	
	if draw_camera_logic:
		draw_logic()

	# This is the same as the push_box logic. I attempted to edit it so that when the target
	# hit the edge it would boost with push_ratio, however that did not work
	var tpos = target.global_position
	var cpos = global_position
	

	var diff_between_left_edges = (tpos.x - target.WIDTH / 2.0) - (cpos.x - box_width / 2.0)
	if diff_between_left_edges < 0:
		global_position.x += diff_between_left_edges 
	#right
	var diff_between_right_edges = (tpos.x + target.WIDTH / 2.0) - (cpos.x + box_width / 2.0)
	if diff_between_right_edges > 0:
		global_position.x += diff_between_right_edges 
		
	#top
	var diff_between_top_edges = (tpos.z - target.HEIGHT / 2.0) - (cpos.z - box_height / 2.0)
	if diff_between_top_edges < 0:
		global_position.z += diff_between_top_edges 
	#bottom
	var diff_between_bottom_edges = (tpos.z + target.HEIGHT / 2.0) - (cpos.z + box_height / 2.0)
	if diff_between_bottom_edges > 0:
		global_position.z += diff_between_bottom_edges 
		
	# This is where I tried to implement the boosting. I also tried to use the speedup 
	# zones in here but that made it even worse
	if tpos.z >= pushbox_top_left.y:
		if tpos.x <= pushbox_top_left.x:
			global_position.x += target.BASE_SPEED * push_ratio
		elif tpos.x >= pushbox_bottom_right.x:
			global_position.x -= target.BASE_SPEED * push_ratio
		global_position.z += target.BASE_SPEED
	if tpos.z <= pushbox_bottom_right.y:
		if tpos.x <= pushbox_top_left.x:
			global_position.x += target.BASE_SPEED * push_ratio
		elif tpos.x >= pushbox_bottom_right.x:
			global_position.x -= target.BASE_SPEED * push_ratio
		global_position.z -= target.BASE_SPEED
			
	
			
		
	super(delta)
		

func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	var left: float = -box_width / 2
	var right: float = box_width / 2
	var top: float = -box_height / 2
	var bottom: float = box_height / 2
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))
	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	# Mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
