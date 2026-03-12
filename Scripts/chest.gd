extends Node3D

var can_open : bool = false

@export var all_items : Array[item]
var chest_item : item

func _ready() -> void:
	chest_item = all_items.pick_random()
	
func _open_chest():
	$chest/chest_lid.visible = false
	print("You got " + chest_item.item_name)


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		can_open = true


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		can_open = false
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and can_open:
		_open_chest()
		$Area3D.monitoring = false
		can_open = false
