class_name HorizontalAutoScroll
extends CameraControllerBase

@export var top_left:Vector2 = Vector2(-8, 8)
@export var bottom_right:Vector2 = Vector2(8, -8)
@export var autoscroll_speed:Vector3 = Vector3(10, 0, 0)

# Height and Width of box border
var box_width: float
var box_height: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	position = Vector3(target.global_position.x, target.global_position.y + 10, target.global_position.z)
	
	box_width = bottom_right.x - top_left.x
	box_height = top_left.y - bottom_right.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if !current:
		return
		
	# Move the camera with autoscroll_speed
	var scroll_speed = autoscroll_speed * delta
	
	# Make the camera view the target from above
	rotation_degrees = Vector3(-90, 0, 0)
	
	global_position += scroll_speed
	
	
	# Make the target scroll with the camera
	target.global_position += Vector3(scroll_speed.x, 0, scroll_speed.z)
	
	# Bound the target within the camera view
	_reposition()
	
	if draw_camera_logic:
		draw_logic()
		
	super(delta)

func _reposition():
	
	# Reposition if target hits one of the borders
	# Left border
	var left_border = (target.global_position.x - target.WIDTH / 2.0) - (global_position.x - box_width / 2.0)
	if left_border < 0:
		target.global_position.x -= left_border
	
	# Right border
	var right_border = (target.global_position.x + target.WIDTH / 2.0) - (global_position.x + box_width / 2.0)
	if right_border > 0:
		target.global_position.x -= right_border
	
	# Top border
	var top_border = (target.global_position.z - target.HEIGHT / 2.0) - (global_position.z - box_height / 2.0)
	if top_border < 0:
		target.global_position.z -= top_border
	
	# Bottom border
	var bot_border = (target.global_position.z + target.HEIGHT / 2.0) - (global_position.z + box_height / 2.0)
	if bot_border > 0:
		target.global_position.z -= bot_border
	


func draw_logic():
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	
	# Draw the border box
	immediate_mesh.surface_add_vertex(Vector3(top_left.x, 0, top_left.y))
	immediate_mesh.surface_add_vertex(Vector3(bottom_right.x, 0, top_left.y))
	immediate_mesh.surface_add_vertex(Vector3(bottom_right.x, 0, top_left.y))
	immediate_mesh.surface_add_vertex(Vector3(bottom_right.x, 0, bottom_right.y))
	immediate_mesh.surface_add_vertex(Vector3(bottom_right.x, 0, bottom_right.y))
	immediate_mesh.surface_add_vertex(Vector3(top_left.x, 0, bottom_right.y))
	immediate_mesh.surface_add_vertex(Vector3(top_left.x, 0, bottom_right.y))
	immediate_mesh.surface_add_vertex(Vector3(top_left.x, 0, top_left.y))

	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)

	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
