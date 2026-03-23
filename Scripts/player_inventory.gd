extends Node

var inventory_items : Array[Item]

func _add_item_to_inventory(i : Item):
	inventory_items.append(i)
	print("You Got: " + i.item_name)
	pass

func _empty_inventory():
	inventory_items = []

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("inventory"):
		for blah in inventory_items:
			print(blah.item_name)
	pass
