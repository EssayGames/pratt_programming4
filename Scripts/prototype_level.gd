extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$pillar/interact_obj.interacted.connect(_door_open)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _door_open():
	print("Door can now Open!")
	
	var t = get_tree().create_tween()
	var gate = get_node("gate-metal-bars2/gate-metal-bars/gate")
	t.tween_property(gate,"global_position", Vector3(gate.global_position.x, -5.0, gate.global_position.z), 3.0)
	t.finished.connect(_door_close)

func _door_close():
	await get_tree().create_timer(3.0).timeout
	var t = get_tree().create_tween()
	var gate = get_node("gate-metal-bars2/gate-metal-bars/gate")
	t.tween_property(gate,"global_position", Vector3(gate.global_position.x, 0.0, gate.global_position.z), 0.5)

func _door_open_not_gate(body):
	if body.is_in_group("player"):
		var anim = get_node("gate-door2/AnimationPlayer")
		anim.play("open")
