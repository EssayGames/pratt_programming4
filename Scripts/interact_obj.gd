extends Node3D

var can_interact : bool = false
signal interacted

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and can_interact:
		interacted.emit()
		can_interact = false
	pass

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		can_interact = true
	pass # Replace with function body.


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		can_interact = false
	pass # Replace with function body.
