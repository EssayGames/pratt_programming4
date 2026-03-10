extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _door_open():
	print("Door can now Open!")
	
	var t = get_tree().create_tween()
	var gate = get_node("gate-metal-bars2/gate-metal-bars/gate")
	t.tween_property(gate,"global_position", Vector3(gate.global_position.x, -5.0, gate.global_position.z), 3.0)
