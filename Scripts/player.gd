extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@export var mouse_sensitivity : float = 0.001

signal raycast_col(col_body)

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	#Base Raycasting functionality is checking collision
	#and then returning the collider node
	if $CameraPivot/Camera3D/RayCast3D.is_colliding():
		var col_body = $CameraPivot/Camera3D/RayCast3D.get_collider()
		#print(col_body.get_parent().name)
		raycast_col.emit(col_body.get_parent().name)

	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation.y -= event.relative.x * mouse_sensitivity
		$CameraPivot.rotation.x -= event.relative.y * mouse_sensitivity
		$CameraPivot.rotation.x = clamp($CameraPivot.rotation.x, deg_to_rad(-65), deg_to_rad(65))
		
