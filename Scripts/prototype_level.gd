extends Node3D

@export var timer_amt : float
var can_open_door : bool = false
@export var has_item : bool = false

#this variable loads in a "packed scene" (a scene that has not yet been loaded into the current scene)
#this packed scene can be used for instantiation in this scene
#and it is loaded as an node scene tree reference
var chest = load("res://Scenes/chest.tscn")

#the @onready keyword is used to set a variable when this scene "enters" or is loaded
#$Markers.get_children() returns an array of nodes that get loaded into the "markers" varaible
@onready var markers = $Markers.get_children()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#connecting the raycast_col signal from the player.gd script
	#passing that into the _inspect_raycast function below
	$Player.raycast_col.connect(_inspect_raycast)
	
	#var current_marker = markers.pick_random()
	#var c = chest.instantiate()
	#current_marker.add_child(c)
	
	#for loops use readable text where the first "variable" in the logic can be any naming convention you want
	#this loop goes through every element in the "markers" array (created in @onready) and adds an instantiated chest scene
	for m in markers:
		var c = chest.instantiate()
		m.add_child(c)
	


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
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()
	
