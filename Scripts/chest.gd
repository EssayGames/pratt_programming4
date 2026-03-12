extends Node3D

var can_open : bool = false
@export var chest_item : item
@export var all_items : Array[item]

func _ready():
	chest_item = all_items.pick_random()
	$icon.texture = chest_item.icon

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and can_open:
		_open_chest()
		can_open = false
		$Area3D.monitoring = false
	pass

func _open_chest():
	$AnimationPlayer.play("open")
	$icon/AnimationPlayer.play("collect")
	$icon/sfx.play()
	Inventory._add_item_to_inventory(chest_item)
	#print("You got " + chest_item.item_name + "!")
	pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		can_open = true

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		can_open = false
	
