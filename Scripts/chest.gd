extends Node3D


#TODO: Get Loot
#TODO: Create Loot Resource

var can_open : bool = false
@export var all_items : Array[Item]
var c_item : Item

func _ready() -> void:
	c_item = all_items.pick_random()
	$ItemIcon.texture = c_item.icon

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		can_open = true
	pass # Replace with function body.


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		can_open = false
	pass # Replace with function body.
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and can_open:
		
		PlayerInventory._add_item_to_inventory(c_item)
		
		#Plays the animation player to open the chest
		$AnimationPlayer.play("open")
		
		#turns off the central bool for opening functionality
		can_open = false
		
		#turns off the trigger area functionality
		$Area3D.monitoring = false
		#TODO: get loot resource
		pass


func _on_lid_anim_done(anim_name: StringName) -> void:
	if anim_name == "open":
		$ItemIcon/icon_anim.play("collect")
	pass # Replace with function body.
