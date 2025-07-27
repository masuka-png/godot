extends CharacterBody3D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * 0.25
		get_node("Camera3D")
		$Camera3D.rotation_degrees.x -= event.relative.y
		$Camera3D.rotation_degrees.x = clamp( 
			$Camera3D.rotation_degrees.x, -80.0, 80.0
		)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	elif event.is_action_pressed("ui_accept"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
func _physics_process(delta):
	const speed = 5.5
	
	var input_direction_2D = Input.get_vector(
		"move_left", "move_right", "move_forward", "move_backward"
	)
	var input_direction_3D = Vector3(
		input_direction_2D.x, 0.0, input_direction_2D.y
	)
	var direction = transform.basis * input_direction_3D
	
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
		
	move_and_slide()
	
