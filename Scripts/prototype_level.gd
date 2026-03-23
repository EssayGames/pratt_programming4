extends Node3D

@export var timer_amt : float
var can_open_door : bool = false
@export var has_item : bool = false

@onready var marker_array = $Markers.get_children()
@onready var rand_marker

var chest = load("res://Scenes/chest.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#connecting the raycast_col signal from the player.gd script
	#passing that into the _inspect_raycast function below
	$Player.raycast_col.connect(_inspect_raycast)
	
	rand_marker = marker_array.pick_random()
	var c = chest.instantiate()
	rand_marker.add_child(c)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _door_open():
	print("Door can now Open!")
	
	var t = get_tree().create_tween()
	
	# the gate variable is a temporary variable to store the path to the gate
	# we want to "animate" with our tween. It is only accessable via this function/method
	var gate = get_node("gate-metal-bars2/gate-metal-bars/gate")
	t.tween_property(gate,"global_position", Vector3(gate.global_position.x, -5.0, gate.global_position.z), 3.0)
	t.finished.connect(_door_close)

func _door_close():
	await get_tree().create_timer(timer_amt).timeout
	var t = get_tree().create_tween()
	var gate = get_node("gate-metal-bars2/gate-metal-bars/gate")
	t.tween_property(gate, "global_position", Vector3(gate.global_position.x, 0.0,  gate.global_position.z), 0.5)

func _got_item():
	$onion.visible = false
	has_item = true
	
func _door_no_gate_open():
	var anim = $"gate-door2/AnimationPlayer"
	#anim.animation_finished.connect(_door_no_gate_close.bind("open"))
	anim.play("open")
	_door_no_gate_close()

func _door_no_gate_close():
	await get_tree().create_timer(1.5).timeout
	var anim = $"gate-door2/AnimationPlayer"
	anim.play("close")
		
func _inspect_raycast(node):
	match node:
		"door":
			can_open_door = true
			print("The raycast has hit the door!")
		"gate":
			print("The raycast has hit the gate!")
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and can_open_door and has_item:
		_door_no_gate_open()
	
