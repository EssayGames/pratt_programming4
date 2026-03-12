extends Node

var inventory_items : Array[item]

func _add_item_to_inventory(i : item):
	inventory_items.append(i)
	
	for element in inventory_items:
		print(element.item_name)
